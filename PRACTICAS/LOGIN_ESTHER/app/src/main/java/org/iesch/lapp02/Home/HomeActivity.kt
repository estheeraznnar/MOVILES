package org.iesch.lapp02.Home

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.lapp02.R
import org.iesch.lapp02.databinding.ActivityHomeBinding

class HomeActivity : AppCompatActivity(){

    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityHomeBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Recupero el correo enviado desde el LoginActivity por un intent
        val correo = intent.getStringExtra("correo_usuario") ?: ""

        //Pongo el correo de titulo de arriba
        binding.Home.text = correo
       //Uso la cadena con foramato que tengo en el string.xml
        val txtbienvenida = getString(R.string.bienvenida, correo)
        binding.bienvenida.text = txtbienvenida

    }

}