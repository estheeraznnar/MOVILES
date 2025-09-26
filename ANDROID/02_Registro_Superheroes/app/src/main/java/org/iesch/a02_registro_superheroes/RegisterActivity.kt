package org.iesch.a02_registro_superheroes

import android.content.Intent
import android.health.connect.datatypes.units.Power
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.databinding.ActivityRegisterBinding
import org.iesch.a02_registro_superheroes.detalle.DetalleHeroeActivity

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        binding.btnGuardar.setOnClickListener {
            // Nos creamos las variables necesarias para pasarlas al Intent
            val superHeroName = binding.etHeroName.text.toString()
            val alterEgo = binding.etAlterEgo.text.toString()
            val bio = binding.etBio.text.toString()
            val power = binding.rbPower.rating

            irADetalleHeroe( superHeroName, alterEgo, bio, power )

        }
    }

    private fun irADetalleHeroe( superHeroName:String, alterEgo: String, bio: String, power: Float ) {
        // El intent debe tener muy claro desde dónde se le llama y a dónde va
        val intent = Intent(this, DetalleHeroeActivity::class.java)

        // Añado los valores al Intent con la función putExtra
        intent.putExtra("heroName", superHeroName)
        intent.putExtra( "alter_ego", alterEgo)
        intent.putExtra("bio",bio)
        intent.putExtra("power", power)

        startActivity(intent)
    }
}