package org.iesch.a02_registro_superheroes.detalle

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.R
import org.iesch.a02_registro_superheroes.databinding.ActivityDetalleHeroeBinding
import org.iesch.a02_registro_superheroes.model.SuperHeroe

class DetalleHeroeActivity : AppCompatActivity() {
    //3. Para no cometer equivocaciones en las kays, me creo un camanion object
    // Un companion object es un objeto que pertenece a una clase de Kotlin y permite definir miembros estaticos
    companion object{
        const val HERO_NAME = "heroName"
        const val ALTER_EGO = "alterEgo"
        const val BIO = "bio"
        const val POWER = "power"

        const val superHeroe_KEY = "super_heroe"
    }

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

        //8. Recibimos el objeto superHeroe del intent
        val superHeroe = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU){
            //Para versiones 33 o superior
         intent.getParcelableExtra(superHeroe_KEY, SuperHeroe::class.java)
        }else{
            @Suppress("DEPRECATION")
            intent.getParcelableExtra<SuperHeroe>(superHeroe_KEY)
        }

        //1. Recibimos los objetos del itent
        //Un objeto es un contenedor de datos que permite almacenar y transportar multiples valores en Actividades o Fragmentos
        /*val bundle = intent.extras!!
        val superHeroeName = bundle.getString(HERO_NAME) ?: "No hay nombre"
        val alterEgo = bundle.getString(ALTER_EGO) ?: "No hay alter ego"
        val bio = bundle.getString(BIO) ?: "No hay bio"
        val power = bundle.getFloat(POWER)*/
        
        //2. Rellenamos con los campos que hemos recibido del binding
        binding.tvHeroNameResult.text = superHeroe?.nombre ?: "No hay nombre"
        binding.tvAlterEgoResult.text = superHeroe?.alterEgo ?: "No hay alter ego"
        binding.tvBioResult.text = superHeroe?.bio ?: "No hay bio"
        binding.rbResultado.rating = superHeroe?.power ?: 0f
            
    }

}