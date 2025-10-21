package org.iesch.app03.quizz

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.app03.R
import org.iesch.app03.databinding.ActivityQuizzResultadoBinding

class QuizzResultadoActivity : AppCompatActivity() {

    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityQuizzResultadoBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityQuizzResultadoBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        // Recupero datos del intent
        val acierto = intent.getBooleanExtra("acierto", false)
        val indice = intent.getIntExtra("indice", 0)
        val total = intent.getIntExtra("totalPreguntas", 0)
        val aciertos = intent.getIntExtra("aciertos", 0)

        // Actualizo el texto para mostrar "Pregunta X de Y"
        binding.segundaPagina.text = getString(R.string.numero_preguta, indice + 1) + " de " + total

        // Si es la última pregunta muestro el resumen final
        if (indice == total - 1) {
            binding.txResultado.text = getString(R.string.final_quizz, aciertos, total)
            // Cambio el texto del botón a "Finalizar"
            binding.btnSiguiente.text = getString(R.string.fin)
        } else {
            // Muestro si la respuesta fue correcta o incorrecta
            val resultado = if (acierto) getString(R.string.respuesta_correcta) else getString(R.string.respuesta_incorrecta)
            binding.txResultado.text = resultado
        }

        // Al pulsar "Siguiente" o "Finalizar" cerramos esta activity y volvemos a PrincipalActivity
        binding.btnSiguiente.setOnClickListener {
            setResult(RESULT_OK)
            finish()
        }
    }
}