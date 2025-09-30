package org.iesch.a02_registro_superheroes.detalle

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.R
import org.iesch.a02_registro_superheroes.databinding.ActivityDetalleHeroeBinding

class DetalleHeroeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDetalleHeroeBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityDetalleHeroeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //1. Recibimos los objetos del itent
        //Un objeto es un contenedor de datos que permite almacenar y transportar multiples valores en Actividades o Fragmentos
        val bundle = intent.extras!!
        val superHeroeName = bundle.getString("heroName") ?: "No hay nombre"
        val alterEgo = bundle.getString("alterEgo") ?: "No hay alter ego"
        val bio = bundle.getString("bio") ?: "No hay bio"
        val power = bundle.getFloat("power")
        
        //2. Rellenamos con los campos que hemos recibido del binding
        binding.tvHeroNameResult.text = superHeroeName
        binding.tvAlterEgoResult.text = alterEgo
        binding.tvBioResult.text = bio
        binding.ratingBar.rating = power
            
    }

}