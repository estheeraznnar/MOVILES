package com.alberto.examen

import android.content.Intent
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.alberto.examen.databinding.ActivityHomeBinding
import com.alberto.examen.ejercicio1.Ejercicio1Activity
import com.alberto.examen.ejercicio2.Ejercicio2Activity
import com.alberto.examen.Pizza.Ejercicio3Activity

class HomeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityHomeBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val correo = intent.getStringExtra("correo_usuario")
        binding.tvBienvenida.text = "Bienvenido: $correo"

        configurarMenu()
    }

    private fun configurarMenu() {
        binding.btnEjercicio1.setOnClickListener { irEjercicio1() }
        binding.btnEjercicio2.setOnClickListener { irEjercicio2() }
        binding.btnEjercicio3.setOnClickListener { irEjercicio3() }
    }

    private fun irEjercicio1() {
        startActivity(Intent(this, Ejercicio1Activity::class.java))
    }

    private fun irEjercicio2() {
        startActivity(Intent(this, Ejercicio2Activity::class.java))
    }

    private fun irEjercicio3() {
        startActivity(Intent(this, Ejercicio3Activity::class.java))
    }

}