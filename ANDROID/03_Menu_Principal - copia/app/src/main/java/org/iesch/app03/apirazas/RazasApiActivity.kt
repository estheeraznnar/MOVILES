package org.iesch.app03.apirazas

import android.os.Bundle
import androidx.appcompat.widget.SearchView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.iesch.app03.R
import org.iesch.app03.apirazas.adapter.DogAdapter
import org.iesch.app03.apirazas.model.APIService
import org.iesch.app03.databinding.ActivityRazasApiBinding
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

//016- como voy a usar el ScreamView necesito descirselo al Activity
class RazasApiActivity : AppCompatActivity(), SearchView.OnQueryTextListener{

    private lateinit var  binding: ActivityRazasApiBinding

    //09
    private lateinit var adapter: DogAdapter
    private val dogImages = mutableListOf<String>()



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRazasApiBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //019-
        binding.svDog.setOnQueryTextListener(this)
        //01- Creamos un metodo que inicia el RecyclerView
        initRecycleView()

    }
    private fun initRecycleView(){
        //010- Hemos de crear el adaptador
        adapter = DogAdapter(dogImages)
        binding.rvDogs.layoutManager = LinearLayoutManager(this)
        binding.rvDogs.adapter = adapter

    }


    //5 - Creamos una instancia de Retrofit
    private fun getRetrofit(): Retrofit{
        return Retrofit.Builder()
            .baseUrl("https://dog.ceo/api/breed/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
    //hasta aqui to do lo de retrofit

    //6 - implemento la funcion de buscar por razas
    private fun buscarPorRaza(raza : String){
        CoroutineScope(Dispatchers.IO).launch{
            //To do lo que se ejecute aqui se esta ejecutando en un hil secundario
            val call = getRetrofit()
                .create<APIService>(APIService::class.java)
                .getPerrosPorRaza("$raza/images")
            val puppies = call.body()

            //011-Estoy en un hilo secundario, ya para pintar la respuesta, necesito volver al hilo principal
            //lo hare mediante runOnUiThread
            runOnUiThread {
                   //*Como el if pintara un Toast o el recycler lo metemos en el hilo principal*//
                if (call.isSuccessful){

                    //Mostramos el recyclerView
                    //011- to do el codigo que se ejecute aqui lo hara en el hilo principal
                    //012- Almacenamos en una variable las imagenes
                    val imagenes = puppies?.images ?: emptyList()

                    //013- Primero borro to do lo que tengamos y añado los datos que recibimos
                    dogImages.clear()
                    dogImages.addAll(imagenes)

                    //014- Avisamos al adaptador de que han habido cambios
                    adapter.notifyDataSetChanged()

                }else{
                    //015- Mostraremos el error en un Toast

                    showError()
                }



            }

        }
    }

    private fun showError() {
        Toast.makeText(this, "Ha ocurrido un error", Toast.LENGTH_LONG).show()
    }

    //017- Implementamos las dos funciones y las completamos
    override fun onQueryTextChange(newText: String?): Boolean {
        //Este metodo nos avisara cada vez que el texto cambie, y aqui no quiero hacer nada.
        return true
    }

    override fun onQueryTextSubmit(query: String?): Boolean {
        //018- Cuando pulsamos buscar se llamara a este metodo
        if (!query.isNullOrEmpty()){
            buscarPorRaza(query.lowercase())
        }
        return true

    }


}