package org.iesch.mi_calculadora

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.mi_calculadora.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        binding.suma.setOnClickListener {

            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                val num1 = n1.toInt()
                val num2 = n2.toInt()
                val suma = num1 + num2
                val res = getString(R.string.resultado_suma, num1, num2, suma)
                binding.resultado.text=res
            }

        }

        binding.resta.setOnClickListener {

            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                val num1 = n1.toInt()
                val num2 = n2.toInt()
                val resta = num1 - num2
                val res = getString(R.string.res_resta, num1, num2, resta)
                binding.resultado.text=res
            }

        }

        binding.division.setOnClickListener {

            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else if (n1 < n2){
                Toast.makeText(this, R.string.toastError, Toast.LENGTH_LONG).show()
            }else{
                val num1 = n1.toInt()
                val num2 = n2.toInt()
                val division = num1 / num2
                val res = getString(R.string.res_div, num1, num2, division)
                binding.resultado.text=res
            }

        }

        binding.multiplicacion.setOnClickListener {

            val n1 = binding.n1.text.toString()
            val n2 = binding.n2.text.toString()

            if (n1.isEmpty() || n2.isEmpty()){
                Toast.makeText(this, R.string.toastText, Toast.LENGTH_LONG).show()
            }else{
                val num1 = n1.toInt()
                val num2 = n2.toInt()
                val multiplicacion = num1 * num2
                val res = getString(R.string.res_multi, num1, num2, multiplicacion)
                binding.resultado.text=res
            }

        }

    }
}