package org.iesch.app03.settings

import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.iesch.app03.R
import org.iesch.app03.databinding.ActivitySettingsBinding
//001- Me creo una funcion de extension
//Nos permite a traves de un componente crear metodos o propiedades adicionales sin necesidad de heredar de la clase original
//Esta funcion de extensiom hereda del Context
val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "settings")
//Este delegado nos permite crear una unica instancia de la base de datos
//name es el nombre de la base de datos

class SettingsActivity : AppCompatActivity() {
    //003
    companion object{
        const val VOLUME_LEVEL = "volume_level"
    }
    private lateinit var binding: ActivitySettingsBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivitySettingsBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        initUI()

    }

    private fun initUI() {
        binding.rsVolumen.addOnChangeListener { _, value, _ ->
            //Log.i("esther", "Guardarndo valor de volumen: $value")
            CoroutineScope(Dispatchers.IO).launch {
                saveVolumen(value.toInt()) //Para que esto funcione hay que meterlo en corrutine
            }
            //Con esto almacenamos el valor
        }
    }

    //002-
    //funcion asincrona ya que le ponemos el suspend
    private suspend fun saveVolumen(value: Int){
        //Aqui ira el codigo para guardar datos en el DataStore
        //No puede ser llamado desde fuera de una corrutina
        dataStore.edit { preferences ->
            preferences[intPreferencesKey(VOLUME_LEVEL)] = value
        }
    }
}