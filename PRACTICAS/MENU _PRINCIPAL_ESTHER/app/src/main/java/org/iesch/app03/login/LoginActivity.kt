package org.iesch.app03.login

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.app03.MenuActivity
import org.iesch.app03.R
import org.iesch.app03.databinding.ActivityLoginBinding

class LoginActivity : AppCompatActivity() {

    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityLoginBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Acciono el boton al click
        binding.boton.setOnClickListener {
            val correo = binding.textEmail.text.toString() //Tomo el valor del campo correo
            val contraseña = binding.contraseA.text.toString() //Tomo el valor del campo contraseña

            //Valido que ambos campos no esten vacios antes de continuar
            if (correo.isNotEmpty() && contraseña.isNotEmpty()){
                //Creo un Intet para ir a HomeActivity y le paso el correo por un extra
                val intent = Intent(this, MenuActivity::class.java)
                intent.putExtra("correo_usuario", correo) //Clave "correo_usuario"
                startActivity(intent) //Inicio la pantalla de HomeActivity
            }else{
                //Muestro un mensaje de error si hay algun campo vacio
                Toast.makeText(this, R.string.toastTextLogin, Toast.LENGTH_LONG).show()
            }
        }
    }
}