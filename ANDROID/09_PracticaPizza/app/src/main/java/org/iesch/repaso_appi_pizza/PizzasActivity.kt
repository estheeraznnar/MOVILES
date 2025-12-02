package org.iesch.repaso_appi_pizza

import android.os.Bundle
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import org.iesch.repaso_appi_pizza.adapter.PizzaAdapter
import org.iesch.repaso_appi_pizza.databinding.ActivityPizzasBinding
import org.iesch.repaso_appi_pizza.model.Pizza
import org.iesch.repaso_appi_pizza.model.PizzaApiService
import org.iesch.repaso_appi_pizza.model.PizzaDataSource
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

// Como voy a usar el SearchView necesito decírselo al Activity
class PizzasActivity : AppCompatActivity(), SearchView.OnQueryTextListener {

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

        binding.svCategorias.setOnQueryTextListener(this)
        initRecyclerView()
        cargarPizzas()
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
                        this@PizzasActivity,
                        "✅ ${pizzas.size} pizzas cargadas",
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

    private fun buscarPorCategoria(categoria: String) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                // Simulamos delay de red
                delay(300)

                // Filtramos por categoría
                val pizzas = PizzaDataSource.getPizzasPorCategoria(categoria)

                runOnUiThread {
                    if (pizzas.isNotEmpty()) {
                        listaPizzas.clear()
                        listaPizzas.addAll(pizzas)
                        adapter.notifyDataSetChanged()

                        Toast.makeText(
                            this@PizzasActivity,
                            "✅ ${pizzas.size} pizzas encontradas",
                            Toast.LENGTH_SHORT
                        ).show()
                    } else {
                        Toast.makeText(
                            this@PizzasActivity,
                            "❌ No hay pizzas en esa categoría",
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                    hideKeyBoard()
                }

            } catch (e: Exception) {
                runOnUiThread {
                    showError()
                    hideKeyBoard()
                }
            }
        }
    }

    private fun showError() {
        Toast.makeText(this, "Ha ocurrido un error al cargar las pizzas", Toast.LENGTH_LONG).show()
    }

    private fun hideKeyBoard() {
        val imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(binding.main.windowToken, 0)
    }

    override fun onQueryTextSubmit(query: String?): Boolean {
        if (!query.isNullOrEmpty()) {
            buscarPorCategoria(query.lowercase())
        } else {
            cargarPizzas()
        }
        return true
    }

    override fun onQueryTextChange(newText: String?): Boolean {
        // Si se borra el texto, volver a cargar todas
        if (newText.isNullOrEmpty()) {
            cargarPizzas()
        }
        return true
    }
}