package org.iesch.app_MENU_ESTHER.login

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.messaging.messaging
import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.remoteConfig
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import org.iesch.app_MENU_ESTHER.MenuActivity
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityRegisterBinding
import org.iesch.app_MENU_ESTHER.login.datastore.LoginDataStoreManager

class RegisterActivity : AppCompatActivity() {

    //view Binding para acceder a los elementos del layout
    private lateinit var binding: ActivityRegisterBinding

    //DataStore para guardar los datos localmente
    private lateinit var loginDataStoreManager: LoginDataStoreManager

    //Firebase Authentication
    private lateinit var auth: FirebaseAuth
    //FirebaseStore para guardar los datos del usuario
    private lateinit var firestore: FirebaseFirestore

    //Remote Config para colores dinamicos
    private lateinit var remoteConfig: FirebaseRemoteConfig

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        // Inicializo el Firebase
        auth = FirebaseAuth.getInstance()
        firestore = FirebaseFirestore.getInstance()
        loginDataStoreManager = LoginDataStoreManager(this)
        remoteConfig = FirebaseRemoteConfig.getInstance()

        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Aplico el color de fondo desde el RemoteConfig
        aplicarColorRemoteConfig()

        // Inicializar listeners de los botones
        initListeners()
    }

    private fun aplicarColorRemoteConfig() {
        // Detectar si está en modo oscuro
        val isNightMode = when (resources.configuration.uiMode and
                android.content.res.Configuration.UI_MODE_NIGHT_MASK) {
            android.content.res.Configuration.UI_MODE_NIGHT_YES -> true
            else -> false
        }

        val colorKey = if (isNightMode) {
            "register_background_color_dark"
        } else {
            "register_background_color_light"
        }

        com.google.firebase.Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            val colorDeFondo = com.google.firebase.Firebase.remoteConfig.getString(colorKey)
            if (colorDeFondo.isNotEmpty()) {
                try {
                    binding.main.setBackgroundColor(android.graphics.Color.parseColor(colorDeFondo))
                } catch (e: Exception) {
                    val defaultColor = if (isNightMode) "#FF000000" else "#F3E5F5"
                    binding.main.setBackgroundColor(android.graphics.Color.parseColor(defaultColor))
                    Log.e("RegisterActivity", "Error al aplicar color: ${e.message}")
                }
            }
        }
    }
    private fun initListeners() {
        // Botón de registro
        binding.btnRegistroFirebase.setOnClickListener {
            val nombre = binding.etNombre.text.toString().trim()
            val email = binding.etUser.text.toString().trim()
            val password = binding.etPassword.text.toString().trim()

            // Validar campos antes de registrar
            if (validarCampos(nombre, email, password)) {
                registrarUsuario(nombre, email, password)
            }
        }

        // TextView para ir al login si ya tiene cuenta
        binding.tvYaTengoCuenta.setOnClickListener {
            finish() // Cierra esta activity y vuelve al Login
        }

    }

    private fun validarCampos(nombre: String, email: String, password: String): Boolean {
        // Validar nombre
        if (nombre.isEmpty()) {
            Toast.makeText(this, "Por favor ingresa tu nombre", Toast.LENGTH_SHORT).show()
            return false
        }

        // Validar email
        if (email.isEmpty()) {
            Toast.makeText(this, "Por favor ingresa tu email", Toast.LENGTH_SHORT).show()
            return false
        }

        // Validar que el email tenga formato correcto
        if (!android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            Toast.makeText(this, "Por favor ingresa un email válido", Toast.LENGTH_SHORT).show()
            return false
        }

        // Validar contraseña
        if (password.isEmpty()) {
            Toast.makeText(this, "Por favor ingresa una contraseña", Toast.LENGTH_SHORT).show()
            return false
        }

        // Firebase requiere mínimo 6 caracteres
        if (password.length < 6) {
            Toast.makeText(this, "La contraseña debe tener al menos 6 caracteres", Toast.LENGTH_SHORT).show()
            return false
        }

        return true
    }

    private fun registrarUsuario(nombre: String, email: String, password: String) {
        lifecycleScope.launch {
            try {
                // Crear usuario en Firebase Authentication
                val result = auth.createUserWithEmailAndPassword(email, password).await()
                val user = result.user

                if (user != null) {
                    // Guardar nombre de usuario en Firestore
                    // La colección se llama "users" y el índice es el email (como pide la práctica)
                    val userData = hashMapOf(
                        "nombre" to nombre,
                        "email" to email,
                        "fechaRegistro" to System.currentTimeMillis()
                    )

                    firestore.collection("users")
                        .document(email) // Usa el email como índice del documento
                        .set(userData)
                        .await()

                    // Guardar en DataStore que se registró con Firebase
                    loginDataStoreManager.saveLoginData(email, password, "firebase")
                    guardarTokenFCM(email)

                    Toast.makeText(this@RegisterActivity, "Registro exitoso", Toast.LENGTH_SHORT).show()

                    // Navegar al menú principal
                    irAMenu()
                }
            } catch (e: Exception) {
                // Manejar errores
                val mensajeError = when {
                    e.message?.contains("already in use") == true ->
                        "Este email ya está registrado"
                    e.message?.contains("network") == true ->
                        "Error de conexión. Verifica tu internet"
                    else -> "Error al registrar: ${e.message}"
                }
                Toast.makeText(this@RegisterActivity, mensajeError, Toast.LENGTH_LONG).show()
            }
        }
    }

    /**
     * Navega al MenuActivity y finaliza todas las activities de autenticación
     */
    private fun irAMenu() {
        val intent = Intent(this, MenuActivity::class.java)
        // Limpia el stack de navegación para que no pueda volver atrás
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
        finish()
    }

    private fun guardarTokenFCM(email: String) {
        com.google.firebase.Firebase.messaging.token.addOnCompleteListener { task ->
            if (task.isSuccessful) {
                val token = task.result
                firestore.collection("users").document(email)
                    .update("token", token)
                    .addOnSuccessListener {
                        android.util.Log.d("FCM", "Token guardado en Firestore")
                    }
            }
        }
    }
}