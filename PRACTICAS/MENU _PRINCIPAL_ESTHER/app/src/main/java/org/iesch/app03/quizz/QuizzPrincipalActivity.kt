package org.iesch.app03.quizz

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.app03.R
import org.iesch.app03.databinding.ActivityQuizzPrincipalBinding

data class Pregunta(
    val texto: String,
    val opciones: List<String>,
    val respuestaCorrecta: Int
)
class QuizzPrincipalActivity : AppCompatActivity() {

    // View Binding para acceder a los elementos del layout de forma segura
    private lateinit var binding: ActivityQuizzPrincipalBinding

    //Creo una lista de preguntas
    private lateinit var preguntas: List<Pregunta>

    // Índice para seguir la pregunta actual
    private var indice = 0

    // Contador de aciertos del usuario
    private var aciertos = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        // Inicializo el binding con el layout de Home
        binding = ActivityQuizzPrincipalBinding.inflate(layoutInflater)
        setContentView(binding.root) // Asigno el layout a la actividad
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Meto las preguntas
        preguntas = listOf(
            Pregunta(getString(R.string.preg1),
                listOf(
                    "Bill Gates",
                    "Steve Jobs",
                    "Elon Musk",
                    "Mark Zuckerberg"
                ),
                1
            ),
            Pregunta(getString(R.string.preg2),
                listOf(
                    getString(R.string.res1),
                    getString(R.string.res2),
                    getString(R.string.res3),
                    getString(R.string.res4),
                ),
                2
            ),
            Pregunta(getString(R.string.preg3),
                listOf("30", "56", "15", "36"),
                1
            ),
            Pregunta(getString(R.string.preg4),
                listOf(
                    getString(R.string.res5),
                    getString(R.string.res6),
                    getString(R.string.res7),
                    getString(R.string.res8),
                ),
                1
            ),
            Pregunta(getString(R.string.preg5),
                listOf(
                    "Windows",
                    "Linux",
                    "MacOS",
                    "Android"
                ),
                1
            )
        )
        mostrarPregunta() // Muestro la primera preguta

        //Configuro el boto de enviar
        binding.btnenviar.setOnClickListener {
            //Compruebo que si se ha seleccionado alguna opcion
            val seleccionada = binding.radioGroup.checkedRadioButtonId
            if (seleccionada == -1){
                //Si no hay niguna oppcion seleccionada, aviso con un Toast
                Toast.makeText(this, R.string.ninguna_respuesta_seleccionada, Toast.LENGTH_SHORT).show()
            }else{
                //Obtengo el indice de la opcion seleccionada segun el id del RadioButton
                val seleccionIndex = when (seleccionada){
                    binding.rbOpcion1.id->0
                    binding.rbOpcion2.id->1
                    binding.rbOpcion3.id->2
                    binding.rbOpcion4.id->3
                    else -> -1
                }

                //Compruebo si la respuesta es correcta
                val esCorrecta = seleccionIndex == preguntas[indice].respuestaCorrecta
                if (esCorrecta) aciertos++ //Incrementp los aciertos si es correcta

                //Creo un Intent para cambiar a ResultadoActivity y pasa los datos
                val intent = Intent(this, QuizzResultadoActivity::class.java)
                intent.putExtra("acierto", esCorrecta)
                intent.putExtra("indice", indice)
                intent.putExtra("totalPreguntas", preguntas.size)
                intent.putExtra("aciertos", aciertos)
                //Inicio la activity y espero  el resultado para continuar
                this.startActivityForResult(intent, 100)
            }
        }
    }

    //Creo un metodo que recibe el resultado al volver de ResultadoActivity
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 100){
            //Avanzo a la siguiente pregunta
            indice ++
            if (indice < preguntas.size){
                mostrarPregunta()
            }else{
                //Si no quedan preguntas se muestra un Toast con el resultado final y cierro la app
                Toast.makeText(this, getString(R.string.final_quizz, aciertos, preguntas.size),
                    Toast.LENGTH_LONG).show()
                finish()
            }
        }
    }

    //Metodo para mostrar la pregunta actual y sus opciones en la UI
    private fun mostrarPregunta() {
        val pregunta = preguntas[indice]
        //Muestro el umero de la pregunta
        binding.txNumPreg.text = getString(R.string.numero_preguta, indice+1)
        //Texto de la pregunta
        binding.txPregunta.text = pregunta.texto

        //Opcciones en cada RadioButton
        binding.rbOpcion1.text = pregunta.opciones[0]
        binding.rbOpcion2.text = pregunta.opciones[1]
        binding.rbOpcion3.text = pregunta.opciones[2]
        binding.rbOpcion4.text = pregunta.opciones[3]

        //Limpio la seleccion previa para empezar sin nada
        binding.radioGroup.clearCheck()
    }
}