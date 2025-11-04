package org.iesch.a08_firebasedam

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.Firebase
import com.google.firebase.analytics.FirebaseAnalytics
import com.google.firebase.analytics.analytics
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import org.iesch.a08_firebasedam.databinding.ActivityLoginBinding

class LoginActivity : AppCompatActivity() {
    private lateinit var binding: ActivityLoginBinding

    //1
    private lateinit var firebaseAnalytics: FirebaseAnalytics

    //4
    private lateinit var auth: FirebaseAuth

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

        //5 - iniciamos la instancia de firebase out
        // Initialize Firebase Auth
        auth = Firebase.auth

        //Configuramos los listeners de los botones
        binding.loginButton.setOnClickListener {
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

        binding.registerButton.setOnClickListener {
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

