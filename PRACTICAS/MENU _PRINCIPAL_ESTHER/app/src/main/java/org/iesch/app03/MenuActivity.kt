package org.iesch.app03

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.app03.apirazas.RazasApiActivity
import org.iesch.app03.calculadora.CalculadoraActivity
import org.iesch.app03.databinding.ActivityMenuBinding
import org.iesch.app03.edad_canina.EdadcaninaActivity
import org.iesch.app03.quizz.QuizzPrincipalActivity
import org.iesch.app03.registro_superheroes.RegisterActivity

class MenuActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMenuBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMenuBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val correo = intent.getStringExtra("correo_usuario")
        binding.tvBienvenida.text = "Hola, $correo"

        configurarMenu()
    }

    private fun configurarMenu() {
        binding.bntCalculadora.setOnClickListener { irCalculadora() }
        binding.btnEdadCanina.setOnClickListener { irEdadCanina() }
        binding.btnQuizz.setOnClickListener { irQuizz() }
        binding.btnSuperheroe.setOnClickListener { irSuperHeroes() }
        binding.btnRazas.setOnClickListener { irRazas() }
    }

    private fun irCalculadora() {
        startActivity(Intent(this, CalculadoraActivity::class.java))
    }

    private fun irEdadCanina() {
        startActivity(Intent(this, EdadcaninaActivity::class.java))
    }

    private fun irQuizz() {
        startActivity(Intent(this, QuizzPrincipalActivity::class.java))
    }

    private fun irSuperHeroes() {
        startActivity(Intent(this, RegisterActivity::class.java))
    }

    private fun irRazas() {
        startActivity(Intent(this, RazasApiActivity::class.java))
    }
}

