package com.alberto.examen.Pizza

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.LinearLayoutManager
import com.alberto.examen.databinding.ActivityPizzasBinding
import com.alberto.examen.Pizza.adapter.PizzaAdapter
import com.alberto.examen.Pizza.model.Pizza
import com.alberto.examen.Pizza.model.PizzaDataSource
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class Ejercicio3Activity : AppCompatActivity(), SearchView.OnQueryTextListener{

    private lateinit var binding: ActivityPizzasBinding
    private lateinit var adapter: PizzaAdapter
    private val listaPizzas = mutableListOf<Pizza>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityPizzasBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.hide()
        ViewCompat.setOnApplyWindowInsetsListener(binding.main) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        getRetrofit()
        initRecyclerView()
        cargarPizzas()
    }

    private fun getRetrofit(): Retrofit {
        return Retrofit.Builder()
            .baseUrl("https://codingpizza.docs.apiary.io/#")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    private fun initRecyclerView() {
        adapter = PizzaAdapter(listaPizzas)
        binding.rvPizzas.layoutManager = LinearLayoutManager(this)
        binding.rvPizzas.adapter = adapter
    }



    private fun cargarPizzas() {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                // Simulamos una llamada a la API con un pequeño delay
                delay(500)

                // Obtenemos los datos mock
                val pizzas = PizzaDataSource.getPizzasMock()

                runOnUiThread {
                    listaPizzas.clear()
                    listaPizzas.addAll(pizzas)
                    adapter.notifyDataSetChanged()

                    Toast.makeText(
                        this@Ejercicio3Activity,
                        "${pizzas.size} pizzas cargadas",
                        Toast.LENGTH_SHORT
                    ).show()
                }

            } catch (e: Exception) {
                runOnUiThread {
                    showError()
                }
            }
        }
    }

    private fun showError() {
        Toast.makeText(this, "Ha ocurrido un error al cargar las pizzas", Toast.LENGTH_LONG).show()
    }

    override fun onQueryTextSubmit(query: String?): Boolean {
        cargarPizzas()
        return true
    }

    override fun onQueryTextChange(newText: String?): Boolean {
        cargarPizzas()
        return true
    }
}