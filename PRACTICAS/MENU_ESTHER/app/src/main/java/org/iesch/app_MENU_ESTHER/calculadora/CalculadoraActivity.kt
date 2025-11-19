package org.iesch.app_MENU_ESTHER.calculadora

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityCalculadoraBinding

class CalculadoraActivity : AppCompatActivity() {
    //Inicializo el ViewBinding para acceder a los elementos de layout
    private lateinit var binding: ActivityCalculadoraBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityCalculadoraBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.hide()
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        //Acciono el boton de la suma
        binding.suma.setOnClickListener {

            //Cojo los nombres del texto y los paso a String
            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            //Verifico si los dos campos tienen valor
            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                //Convierto los valores del texto a Double para que admita decimales
                val num1 = n1.toDouble()
                val num2 = n2.toDouble()
                val suma = num1 + num2
                //Hago el mensaje usando el string con formato decimal
                val res = getString(R.string.resultado_suma, num1, num2, suma)
                binding.resultado.text=res //muestro el resultado
            }

        }

        //Acciono el boton de la resta
        binding.resta.setOnClickListener {

            //Cojo los nombres del texto y los paso a String
            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            //Verifico si los dos campos tienen valor
            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                //Convierto los valores del texto a Double para que admita decimales
                val num1 = n1.toDouble()
                val num2 = n2.toDouble()
                val resta = num1 - num2
                //Hago el mensaje usando el string con formato decimal
                val res = getString(R.string.res_resta, num1, num2, resta)
                binding.resultado.text=res//muestro el resultado
            }

        }

        //Acciono el boton de la division
        binding.division.setOnClickListener {

            //Cojo los nombres del texto y los paso a String
            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            //Verifico si los dos campos tienen valor
            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()

                //Compruebo que el segundo numero no sea 0 para evitar la division por cero
            }else if (n2.toDouble() == 0.0){
                Toast.makeText(this, R.string.toastError, Toast.LENGTH_LONG).show()
            }else{
                //Convierto los valores del texto a Double para que admita decimales
                val num1 = n1.toDouble()
                val num2 = n2.toDouble()
                val division = num1 / num2
                //Hago el mensaje usando el string con formato decimal
                val res = getString(R.string.res_div, num1, num2, division)
                binding.resultado.text=res//muestro el resultado
            }

        }

        //Acciono el boton de multiplicacion
        binding.multiplicacion.setOnClickListener {

            //Cojo los nombres del texto y los paso a String
            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            //Verifico si los dos campos tienen valor
            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                //Convierto los valores del texto a Double para que admita decimales
                val num1 = n1.toDouble()
                val num2 = n2.toDouble()
                val multiplicacion = num1 * num2
                //Hago el mensaje usando el string con formato decimal
                val res = getString(R.string.res_multi, num1, num2, multiplicacion)
                binding.resultado.text=res //muestro el resultado
            }

        }

    }
}