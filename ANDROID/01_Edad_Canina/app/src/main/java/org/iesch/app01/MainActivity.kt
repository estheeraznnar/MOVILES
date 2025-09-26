package org.iesch.app01

import android.annotation.SuppressLint
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //Aqui la pantalla está mostrada

        //1º - Tomamos el control de todos los elementos de ña parte de la UI
        val resultText = findViewById<TextView>(R.id.tvRespuesta)
        val btnCalcular = findViewById<Button>(R.id.btnCalcular)
        val ageEdit = findViewById<EditText>(R.id.etEdad)

        //2º Los botones tienen la propiedead setOnClicklistener al pulsarlos
        btnCalcular.setOnClickListener {
            //Aqui va el codigo de lo que queremos hacer al pulsar el boton de Calcular
            val edadString = ageEdit.text.toString()  //Los edit text siempre los dan en String

            if (edadString.isEmpty()){
                //No hacemos nada
                // 3º Me creo un mensaje de tipo Toast
                Toast.makeText(this, R.string.toastText,
                    Toast.LENGTH_LONG).show()
            }else{
                val edadInt = edadString.toInt() //Lo pasamos de String a Int
                val dogEdad = edadInt / 7
                val resultado = getString(R.string.resultFormat, dogEdad)
                resultText.text = resultado
            }

        }
    }
}