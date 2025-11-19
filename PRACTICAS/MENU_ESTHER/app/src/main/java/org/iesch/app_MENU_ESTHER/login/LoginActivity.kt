package org.iesch.app_MENU_ESTHER.login

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.credentials.Credential
import androidx.credentials.CredentialManager
import androidx.credentials.CustomCredential
import androidx.credentials.GetCredentialRequest
import androidx.lifecycle.lifecycleScope
import com.google.android.libraries.identity.googleid.GetGoogleIdOption
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential.Companion.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL
import com.google.firebase.Firebase
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider
import com.google.firebase.auth.auth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.firestoreSettings
import com.google.firebase.messaging.messaging
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import com.google.firebase.remoteconfig.remoteConfig
import com.google.firebase.remoteconfig.remoteConfigSettings
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import org.iesch.app_MENU_ESTHER.MenuActivity
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityLoginBinding
import org.iesch.app_MENU_ESTHER.login.datastore.LoginDataStoreManager
import kotlin.toString


enum class ProviderType {
    EMAILYCONTRASENA,
    GOOGLE
}
class LoginActivity : AppCompatActivity() {
    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityLoginBinding

    //Hago una instancia del DataStore Manger para gestionar el Login
    private lateinit var loginDataStore: LoginDataStoreManager

    // Firebase Authentication
    private lateinit var auth: FirebaseAuth
    private val db = FirebaseFirestore.getInstance()

    // Launcher para solicitar permisos
    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission(),
    ) { isGranted: Boolean ->
        if (isGranted) {
            Log.d("FCM", "Permiso de notificaciones concedido")
        } else {
            Log.d("FCM", "Permiso de notificaciones denegado")
        }
    }



    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()

        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        try {
            FirebaseFirestore.getInstance().firestoreSettings = firestoreSettings {
                isPersistenceEnabled = true
            }
        } catch (e: Exception) {
            Log.e("LoginActivity", "Firestore ya inicializado")
        }
        //Inicializo el DataStore Manager
        loginDataStore = LoginDataStoreManager(this)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Initialize Firebase Auth
        auth = Firebase.auth
        loginDataStore = LoginDataStoreManager(this)

        // Solicitar permisos de notificaciones
        solicitarPermisosPush()

        // Notificaciones Push
        notificacionesPush()

        // Configuración remota
        configuracionRemota()

        //Configuto el boton de acceso
        initListener()
    }

    private fun configuracionRemota() {
        val configSettings: FirebaseRemoteConfigSettings = remoteConfigSettings {
            minimumFetchIntervalInSeconds = 60
        }

        // Obtengo la instancia de remote config
        val firebaseConfig = Firebase.remoteConfig

        // Aplico la configuración
        firebaseConfig.setConfigSettingsAsync(configSettings)

        // Establezco los valores por defecto
        firebaseConfig.setDefaultsAsync(mapOf(
            "login_background_color_light" to "#E3F2FD",      // Azul claro
            "login_background_color_dark" to "FF000000",
            "register_background_color_light" to "#F3E5F5",   // Morado claro
            "register_background_color_dark" to "FF000000",
            "menu_background_color_light" to "#E8F5E9",       // Verde claro
            "menu_background_color_dark" to "FF000000"
        ))

        // Aplicar el color de fondo
        Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            aplicarColorSegunTema("login")
        }

    }

    private fun aplicarColorSegunTema(fondo: String) {
        // Detectar si está en modo oscuro
        val isNightMode = when (resources.configuration.uiMode and
                android.content.res.Configuration.UI_MODE_NIGHT_MASK) {
            android.content.res.Configuration.UI_MODE_NIGHT_YES -> true
            else -> false
        }

        // Obtener el color correspondiente
        val colorKey = if (isNightMode) {
            "${fondo}_background_color_dark"
        } else {
            "${fondo}_background_color_light"
        }

        val colorDeFondo = Firebase.remoteConfig.getString(colorKey)
        if (colorDeFondo.isNotEmpty()) {
            try {
                binding.main.setBackgroundColor(android.graphics.Color.parseColor(colorDeFondo))
            } catch (e: Exception) {
                // Color por defecto según el tema
                val defaultColor = if (isNightMode) "#FF000000" else "#E3F2FD"
                binding.main.setBackgroundColor(android.graphics.Color.parseColor(defaultColor))
                Log.e("LoginActivity", "Error al aplicar color: ${e.message}")
            }
        }
    }

    /**
     * Funcion para inicializar el boton.
     * Y tambien para validar el email y la contraseña, y guardarlos en el DataStore
     */
    private fun initListener() {
        // Configuramos los listeners de los botones
        binding.btnLoginFirebase.setOnClickListener {
            logueoConUsuarioYContrasena()
        }

        binding.btnLoginGoogle.setOnClickListener {
            logueoConGoogle()
        }

        binding.tvRegister.setOnClickListener {
            val intent = Intent(this, RegisterActivity::class.java)
            startActivity(intent)
        }
    }

    private fun logueoConUsuarioYContrasena() {
        // Comprobamos si hemos introducido email y contraseña
        if (binding.etUser.text!!.isNotEmpty() && binding.etPassword.text!!.isNotEmpty()) {
            // Nos autenticamos con email y contraseña
            val usuario = binding.etUser.text.toString().trim()
            val password = binding.etPassword.text.toString().trim()

            auth.signInWithEmailAndPassword(usuario, password)
                // Añadimos un listener para comprobar si el usuario se ha logueado correctamente
                .addOnCompleteListener { logueo ->
                    if (logueo.isSuccessful) {
                        // El usuario se ha logueado correctamente
                        lifecycleScope.launch {
                            // Guardar en DataStore con tipo "firebase"
                            loginDataStore.saveLoginData(usuario, password, "firebase")

                            // Guardar token FCM en Firestore
                            guardarTokenFCM(usuario)
                        }

                        mostrarMenuActivity(usuario, ProviderType.EMAILYCONTRASENA.toString())
                    } else {
                        // Ha habido un error
                        mostrarError()
                    }
                }
        } else {
            // Avisamos al usuario que ha de rellenar los campos
            avisoUsuario()
        }
    }

    private fun logueoConGoogle() {
        // Instanciamos una solicitud de inicio con Google
        val googleIdOption = GetGoogleIdOption.Builder()
            .setServerClientId(getString(R.string.web_client))
            .setFilterByAuthorizedAccounts(false)
            .build()

        // Generamos la solicitud de credenciales
        val request = GetCredentialRequest.Builder()
            .addCredentialOption(googleIdOption)
            .build()

        // Obtenemos el CredentialManager y lanzamos la solicitud
        lifecycleScope.launch {
            try {
                val credentialManager = CredentialManager.create(this@LoginActivity)
                val result = credentialManager.getCredential(
                    request = request,
                    context = this@LoginActivity
                )
                handleSignIn(result.credential)
            } catch (e: Exception) {
                Log.e("DAM", "Error al obtener las credenciales: ${e.message}")
            }
        }
    }

    private fun handleSignIn(credential: Credential) {
        // Check if credential is of type Google ID
        if (credential is CustomCredential && credential.type == TYPE_GOOGLE_ID_TOKEN_CREDENTIAL) {
            // Create Google ID Token
            val googleIdTokenCredential = GoogleIdTokenCredential.createFrom(credential.data)
            // Sign in to Firebase using the token
            firebaseAuthWithGoogle(googleIdTokenCredential.idToken)
        } else {
            Log.w("DAM", "Credential is not of type Google ID!")
        }
    }

    private fun firebaseAuthWithGoogle(idToken: String) {
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        auth.signInWithCredential(credential)
            .addOnCompleteListener(this) { task ->
                if (task.isSuccessful) {
                    val user = auth.currentUser
                    val email = user?.email ?: ""
                    val nombre = user?.displayName ?: ""

                    lifecycleScope.launch {
                        try {
                            // Esperar un poco para asegurar conexión
                            kotlinx.coroutines.delay(500)

                            val docRef = db.collection("users").document(email)
                            val document = docRef.get().await()

                            if (!document.exists()) {
                                val userData = hashMapOf(
                                    "nombre" to nombre,
                                    "email" to email,
                                    "fechaRegistro" to System.currentTimeMillis()
                                )
                                docRef.set(userData).await()
                                Log.d("LoginActivity", "Usuario creado en Firestore")
                            }

                            loginDataStore.saveLoginData(email, "", "google")
                            guardarTokenFCM(email)
                            mostrarMenuActivity(email, ProviderType.GOOGLE.toString())

                        } catch (e: Exception) {
                            Log.e("LoginActivity", "Error: ${e.message}")
                            // Navegar al menú de todas formas (los datos se sincronizarán después)
                            runOnUiThread {
                                Toast.makeText(
                                    this@LoginActivity,
                                    "Sesión iniciada. Los datos se sincronizarán cuando haya conexión.",
                                    Toast.LENGTH_LONG
                                ).show()
                            }
                            mostrarMenuActivity(email, ProviderType.GOOGLE.toString())
                        }
                    }
                } else {
                    Log.e("LoginActivity", "Google sign-in failed")
                    Toast.makeText(this, "Error al iniciar sesión con Google", Toast.LENGTH_SHORT).show()
                }
            }
    }

    private fun solicitarPermisosPush() {
        // Solo necesitamos solicitar permiso en Android 13 (API 33) o superior
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            when {
                ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.POST_NOTIFICATIONS
                ) == PackageManager.PERMISSION_GRANTED -> {
                    // El permiso ya está concedido
                    Log.d("FCM", "Permiso de notificaciones ya concedido")
                }
                else -> {
                    // Solicitar el permiso
                    requestPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
                }
            }
        }
    }

    private fun notificacionesPush() {
        // Vamos a obtener el token de registro
        Firebase.messaging.token.addOnCompleteListener { task ->
            if (task.isSuccessful) {
                val token = task.result
                Log.d("FCM", "Token de registro: $token")
            } else {
                Log.d("FCM", "Error al obtener el token de registro")
            }
        }
    }

    private suspend fun guardarTokenFCM(email: String) {
        try {
            Firebase.messaging.token.addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    val token = task.result
                    // Guardar el token en Firestore en el campo "token" del usuario
                    db.collection("users").document(email)
                        .update("token", token)
                        .addOnSuccessListener {
                            Log.d("FCM", "Token guardado en Firestore")
                        }
                        .addOnFailureListener { e ->
                            Log.e("FCM", "Error al guardar token: ${e.message}")
                        }
                }
            }
        } catch (e: Exception) {
            Log.e("FCM", "Error: ${e.message}")
        }
    }

    private fun avisoUsuario() {
        // Mostramos el error mediante un AlertDialog
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Error")
        builder.setMessage("Rellena los campos, por favor.")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostrarError() {
        // Mostramos el error mediante un AlertDialog
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Error de autenticación")
        builder.setMessage("No se ha podido iniciar sesión. Revisa tu email y password e inténtalo de nuevo.")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostrarMenuActivity(usuario: String, provider: String) {
        val intent = Intent(this, MenuActivity::class.java)
        intent.putExtra("usuario", usuario)
        intent.putExtra("provider", provider)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
        finish()
    }

    override fun onStart() {
        super.onStart()
        // Compruebo si el usuario ya ha accedido
        lifecycleScope.launch {
            val estaLogueado = loginDataStore.isLogger.first()
            if (estaLogueado) {
                val email = loginDataStore.userEmail.first()
                val loginType = loginDataStore.loginType.first()
                mostrarMenuActivity(email, loginType)
            }
        }
    }

}
