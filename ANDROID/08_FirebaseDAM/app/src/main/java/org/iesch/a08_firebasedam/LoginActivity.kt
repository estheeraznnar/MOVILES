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
import kotlinx.coroutines.launch
import org.iesch.a08_firebasedam.databinding.ActivityLoginBinding

class LoginActivity : AppCompatActivity() {
    private lateinit var binding: ActivityLoginBinding

    //1
    private lateinit var firebaseAnalytics: FirebaseAnalytics

    //4
    private lateinit var auth: FirebaseAuth
    //Creamos ellauncher para solicitar los permisos
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
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        iniciarAnalytics()

        //Solicitar oermisos de notificaciones
        solicitarPermisosPush()
        //Notificaciones push
        notificacionesPush()

        //5 - iniciamos la instancia de firebase out
        // Initialize Firebase Auth
        auth = Firebase.auth

        //me puedo suscribir por temas
        Firebase.messaging.subscribeToTopic("FCBarcelona")
            .addOnCompleteListener { task ->
                if (task.isSuccessful){
                    Log.d("FCM", "Suscrito al FC Barcelona")
                }else{
                    Log.d("FCM", "Error al suscribirse al FC Barcelona")
                }
            }

        //Configuramos los listeners de los botones
        binding.loginButton.setOnClickListener { botonLogin() }

        binding.registerButton.setOnClickListener { botonRegister() }

        binding.loginGoogleButton.setOnClickListener { botonLoginGoogle() }
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
        //Vamos a obtener el token de registro
        Firebase.messaging.token.addOnCompleteListener { task ->
            if (task.isSuccessful){
                val token = task.result
                Log.d("FCM", "Token de registro: $token")
            }else{
                Log.d("FCM", "Error al obtener el token de registro")
            }
        }
    }

    private fun botonLoginGoogle() {
        // Vamos a crearlo siguiendo la documentacion oficial
        // Instanciamos una solicitud de inicio con Google
        val googleIdOption = GetGoogleIdOption.Builder()
            .setServerClientId(getString(R.string.web_client))
            .setFilterByAuthorizedAccounts(true)
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
                    mostramosHomeActivity( user?.email.toString(), ProviderType.GOOGLE.toString() )
                } else {
                    Log.e("DAM", "Error al loguearnos con Google")
                }
            }
    }

    private fun botonRegister() {
        //Comprobamos si hemos introducido email y contraseña
        if (binding.emailEditText.text.isNotEmpty() && binding.passwordEditText.text.isNotEmpty()){
            //Nos autenticamos con email y contraseña
            val usuario = binding.emailEditText.text.toString()
            val passwd = binding.passwordEditText.text.toString()
            auth.createUserWithEmailAndPassword(usuario, passwd)
                //Añadimos un listenner para comprobar si el usuario se ha registrado correctamente o no
                .addOnCompleteListener { registro ->
                    if (registro.isSuccessful){
                        //El usuario se ha registrado correctamente correctamente
                        mostrarRegistroCorrecto()
                    }else{
                        //Ha habido un error
                        mostrarError()
                    }
                }
        }else{
            //Avisamos al usuario que ha de rellenar los campos
            avisoUsuario()
        }
    }


    private fun botonLogin() {
        //Comprobamos si hemos introducido email y contraseña
        if (binding.emailEditText.text.isNotEmpty() && binding.passwordEditText.text.isNotEmpty()){
            //Nos autenticamos con email y contraseña
            val usuario = binding.emailEditText.text.toString()
            val passwd = binding.passwordEditText.text.toString()
            auth.signInWithEmailAndPassword(usuario, passwd)
                //Añadimos un listenner para comprobar si el usuario se ha logueado correctamente o no
                .addOnCompleteListener { logueo ->
                    if (logueo.isSuccessful){
                        //El usuario se ha logueado correctamente
                        mostramosHomeActivity(usuario, ProviderType.EMAIL_CONTRASEÑA.toString())
                    }else{
                        //Ha habido un error
                        mostrarError()
                    }
                }
        }else{
            //Avisamos al usuario que ha de rellenar los campos
            avisoUsuario()
        }
    }


    private fun mostrarRegistroCorrecto() {
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Usuario Registrad")
        builder.setMessage("El usuario se ha registrado correctamente")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun avisoUsuario() {
        //Mostramos el error mediante un AletrDialog
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Error")
        builder.setMessage("Rellena los campos")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostrarError() {
        //Mostramos el error mediante un AletrDialog
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Error de autenticacion")
        builder.setMessage("No se ha podido iniciar sesion. Revisa tu email y password e intentalo de nuevo")
        builder.setPositiveButton("Aceptar", null)
        val dialog = builder.create()
        dialog.show()
    }

    private fun mostramosHomeActivity(usuario: String, provider: String) {
        val intent = Intent(this, HomeActivity::class.java)
        intent.putExtra("usuario", usuario)
        intent.putExtra("provider", provider)
        startActivity(intent)
    }

    override fun onStart() {
        super.onStart()
        //Compruebo si el usuario ya ha accedido
        val currentUser = auth.currentUser
        if (currentUser != null) {
            //si el usuario actual es diferente a null estara logueado
            val intent = Intent(this, HomeActivity::class.java)
            val nombre = currentUser.let {
                it.email
            }
            intent.putExtra("usuario", nombre)
            startActivity(intent)
        }
    }

    private fun iniciarAnalytics(){
        //2
        firebaseAnalytics = Firebase.analytics

        //3 - Comprobamos que la intefracion funciona correctamente registrando un evento
        val bundle = Bundle()
        bundle.putString("mensaje", "Integracion con firebase creada correctamente")
        firebaseAnalytics.logEvent("LogingScreen", bundle)
    }
}

