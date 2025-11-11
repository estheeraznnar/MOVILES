package org.iesch.a08_firebasedam

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
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
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.analytics.analytics
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider
import com.google.firebase.auth.auth
import com.google.firebase.messaging.messaging
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import com.google.firebase.remoteconfig.remoteConfig
import com.google.firebase.remoteconfig.remoteConfigSettings
import kotlinx.coroutines.launch
import org.iesch.a08_firebasedam.databinding.ActivityLoginBinding


class LoginActivity : AppCompatActivity() {

    private lateinit var binding: ActivityLoginBinding
    private lateinit var firebaseAnalytics: FirebaseAnalytics
    private lateinit var auth: FirebaseAuth

    //Launcher para solicitar permisos
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
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityLoginBinding.inflate( layoutInflater )
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        // Initialize Firebase Auth
        auth = Firebase.auth
        // Analytics
        iniciarAnalytics()
        // Solicitar PErmisos de Notificaciones
        solicitarPermisosPush()
        // Notificaciones Push
        notificacionesPush()

        configuracionRemota()

        // Iniciamos los listeners para los botones
        initUI()

    }

    private fun configuracionRemota() {
        //Lo recomendable es definir un valor por defecto para todos estos valores remotos
        val configSettings: FirebaseRemoteConfigSettings= remoteConfigSettings {
            minimumFetchIntervalInSeconds = 60
        }
        //Obtenemos la intancia de remote config
        val firebaseConfig = Firebase.remoteConfig
        //Aplicamos la configuracion a la remote config
        firebaseConfig.setConfigSettingsAsync(configSettings)
        //Establecemos los valores por defecto en caso de que falle la detencion de kis valores remotos
        firebaseConfig.setDefaultsAsync(mapOf(
            "show_optional_button" to false,
            "optional_button_text" to "Texto por defecto",
            "color_bg" to "bg_1"
        ))
    }

    private fun initUI() {

        // Configuramos los listeners de los botones
        binding.loginButton.setOnClickListener {
            logueoConUsuarioYContrasena()
        }
        binding.registerButton.setOnClickListener {
            registroConUsuarioYContrasena()
        }

        binding.loginGoogleButton.setOnClickListener {
            logueoConGoogle()
        }

    }

    private fun logueoConUsuarioYContrasena() {
        // Comprobamos si hemos introducido email y contraseña
        if ( binding.emailEditText.text.isNotEmpty() && binding.passwordEditText.text.isNotEmpty() ){
            // Nos autenticamos con email y contraseña
            val usuario = binding.emailEditText.text.toString()
            val password = binding.passwordEditText.text.toString()
            auth.signInWithEmailAndPassword( usuario, password )
                // Añadimos un listener para comprobar si el usuario se ha logueado correctamente o no
                .addOnCompleteListener { logueo ->
                    if ( logueo.isSuccessful ){
                        // El usuario se ha logueado correctamente
                        mostrarHomeActivity( usuario, ProviderType.EMAILYCONTRASENA.toString() )
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

    private fun registroConUsuarioYContrasena() {
        // Comprobamos si hemos introducido email y contraseña
        if ( binding.emailEditText.text.isNotEmpty() && binding.passwordEditText.text.isNotEmpty() ){
            // Nos autenticamos con email y contraseña
            val usuario = binding.emailEditText.text.toString()
            val password = binding.passwordEditText.text.toString()
            auth.createUserWithEmailAndPassword( usuario, password )
                // Añadimos un listener para comprobar si el usuario se ha registrado correctamente o no
                .addOnCompleteListener { registro ->
                    if ( registro.isSuccessful ){
                        // El usuario se ha registrado correctamente
                        mostrarRegistroCorrecto()
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
            if (task.isSuccessful){
                val token = task.result
                Log.d("FCM", "Token de registro: $token")
            } else {
                Log.d("FCM", "Error al obtener el token de registro")
            }
        }

        // Me puedo suscribir por temas
        Firebase.messaging.subscribeToTopic("RealMadrid")
            .addOnCompleteListener { task ->
                if (task.isSuccessful ){
                    Log.d("FCM", "Suscrito a Real Madrid")
                } else {
                    Log.d("FCM", "Error en la suscripcion a Real Madrid")
                }
            }
    }

    private fun logueoConGoogle() {
        // Vamos a crearlo siguiendo la documentacion oficial
        // Instanciamos una solicitud de inicio con Google
        val googleIdOption = GetGoogleIdOption.Builder()
            .setServerClientId(getString(R.string.web_client))
            .setFilterByAuthorizedAccounts(false)
            .build()
        // Generamos la solicitud de credenciales
        val request = GetCredentialRequest.Builder()
            .addCredentialOption( googleIdOption )
            .build()
        // Obtenemos el CredentialManager y lanzamos la solicitud
        lifecycleScope.launch {
            try {
                val credentialManager = CredentialManager.create( this@LoginActivity )
                val result = credentialManager.getCredential(
                    request = request,
                    context = this@LoginActivity
                )
                handleSignIn(result.credential)
            } catch (e: Exception ){
                Log.e("DAM", "Error al obtener las credenciales: ${e.message}")
            }
        }
    }

    private fun handleSignIn(credential: Credential) {
        // Check if credential is of type Google ID
        if (credential is CustomCredential && credential.type == TYPE_GOOGLE_ID_TOKEN_CREDENTIAL) {
            // Create Google ID Token
            val googleIdTokenCredential = GoogleIdTokenCredential.createFrom(credential.data)

            // Sign in to Firebase with using the token
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
                    // Aqui ya nos hemos logueado con Google de manera exitosa
                    Log.d("DAM", "signInWithCredential:success")
                    val user = auth.currentUser
                    mostrarHomeActivity( user?.email.toString(), ProviderType.GOOGLE.toString() )
                } else {
                    Log.e("DAM", "Error al loguearnos con Google")
                }
            }
    }

    private fun mostrarRegistroCorrecto() {
        // Mostramos el error mediante un AlertDialog
        val builder = AlertDialog.Builder( this )
        builder.setTitle("Usuario Registrado")
        builder.setMessage("El usuario se ha registrado correctamente")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun avisoUsuario() {
        // Mostramos el error mediante un AlertDialog
        val builder = AlertDialog.Builder( this )
        builder.setTitle("Error")
        builder.setMessage("Rellena los campos, capuyo.")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostrarError() {
        // Mostramos el error mediante un AlertDialog
        val builder = AlertDialog.Builder( this )
        builder.setTitle("Error de autenticación")
        builder.setMessage("No se ha podido iniciar sesión. Revisa tu email y password e inténtalo de nuevo.")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostrarHomeActivity( usuario: String, provider: String ) {
        val intent = Intent(this, HomeActivity::class.java)
        intent.putExtra("usuario", usuario)
        intent.putExtra("provider", provider)
        startActivity( intent )

    }

    override fun onStart() {
        super.onStart()
        // Compruebo si el usuario ya ha accedido
        val usuarioActual = auth.currentUser
        if (usuarioActual != null) {
            // Si el usuario actial es diferente de null, estará logueado
            val intent = Intent( this, HomeActivity::class.java)
            val nombre = usuarioActual.let {
                it.email
            }
            intent.putExtra("usuario", nombre)
            startActivity( intent )
        }
    }

    private fun iniciarAnalytics() {
        firebaseAnalytics = Firebase.analytics
        val bundle = Bundle()
        bundle.putString("mensaje", "Integración con Firebase realizada correctamente.")
        firebaseAnalytics.logEvent("LoginScreen", bundle)
    }
}
