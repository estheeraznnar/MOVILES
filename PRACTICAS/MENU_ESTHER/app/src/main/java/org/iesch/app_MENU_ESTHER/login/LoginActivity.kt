package org.iesch.app_MENU_ESTHER.login

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import org.iesch.app_MENU_ESTHER.MenuActivity
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityLoginBinding
import org.iesch.app_MENU_ESTHER.login.datastore.LoginDataStoreManager
import kotlin.toString

class LoginActivity : AppCompatActivity() {
    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityLoginBinding

    //Hago una instancia del DataStore Manger para gestionar el Login
    private lateinit var loginDataStore: LoginDataStoreManager

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        //Inicializo el DataStore Manager
        loginDataStore = LoginDataStoreManager(this)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Compruebo si el usuario ya esta logueado
        comprobarSiUsuLog()

        //Configuto el boton de acceso
        initListener()
    }

    //Esta función sirve para comprobar si un usuario ya esta logueado al iniciar
    private fun comprobarSiUsuLog() {
        lifecycleScope.launch {
            //Obtengo el primer valor del Flow estaLogueado
            val estaLogueado = loginDataStore.isLogger.first()
            if (estaLogueado){
                //Si el usuario esta logueado, voy directamente al MenuActivity
                irAMenu()
            }
        }
    }

    private fun irAMenu() {
        val intent = Intent(this, MenuActivity::class.java)
        startActivity(intent)
        //Finalizo el LoginActivity para que no se pueda volver una vez dentro
        finish()
    }

    /**
     * Funcion para inicializar el boton.
     * Y tambien para validar el email y la contraseña, y guardarlos en el DataStore
     */
    private fun initListener() {
        binding.boton.setOnClickListener {
            val correo = binding.textEmail.text.toString() //Tomo el valor del campo correo
            val contraseña = binding.contraseA.text.toString() //Tomo el valor del campo contraseña

            //Valido que el email no este vacio
            if (correo.isEmpty()){
                Toast.makeText(this, R.string.toastTextLoginEmail, Toast.LENGTH_LONG).show()
                return@setOnClickListener
            }

            //Valido que la contraseña no este vacia
            if (contraseña.isEmpty()){
                Toast.makeText(this, R.string.toastTextLoginContra, Toast.LENGTH_LONG).show()
                return@setOnClickListener
            }

            //Si las validaciones son correctas, guardo los datos
            lifecycleScope.launch {
                loginDataStore.saveLoginData(correo, contraseña)
                Toast.makeText(this@LoginActivity, R.string.toastTextLogin, Toast.LENGTH_SHORT).show()
                irAMenu()
            }
        }
    }
}
