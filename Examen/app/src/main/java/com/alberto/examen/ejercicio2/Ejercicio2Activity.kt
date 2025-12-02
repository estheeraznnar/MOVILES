package com.alberto.examen.ejercicio2

import android.content.Context
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.preferencesDataStore
import com.alberto.examen.R
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.lifecycle.lifecycleScope
import com.alberto.examen.databinding.ActivityEjercicio2Binding
import com.alberto.examen.ejercicio2.data.DataStoreManager
import com.alberto.examen.ejercicio2.data.SettingsData
import com.alberto.examen.login.LoginDataStoreManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.filter
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
/*import kotlin.io.root*/

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "ejercicio2")

class Ejercicio2Activity : AppCompatActivity() {

    companion object{
        const val KEY_DARKMODE = "darkmode_enabled"
        const val VOLUMEN_KEY = "volume_enabled"
        const val CHEK_NOTIFICACIONES = "notificaciones_enabled"
        const val KEY_SINCRONIZACION = "sincronizacion_enabled"
    }

    private lateinit var binding: ActivityEjercicio2Binding
    // 8
    private var firstTime: Boolean = true
    private lateinit var dataStoreManager: DataStoreManager

    private lateinit var loginDataStore: LoginDataStoreManager


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityEjercicio2Binding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // Obtengo el email del usuario para sincronizar el modo oscuro
        lifecycleScope.launch {
            val userEmail = loginDataStore.userEmail.first()
            if (userEmail.isNotEmpty()) {
                dataStoreManager = DataStoreManager(this@Ejercicio2Activity, userEmail)
            }
        }

        // 6 Llamo a la funcion para obtener los datos guardados
        // Vamos a consumir ese Flow
        /*CoroutineScope(Dispatchers.IO).launch {
            getSettigs().filter { firstTime }.collect { datosAlmacenados ->
                // 7 Actualizar la UI en el hilo principal. NO se puede tocar la interfaz desde un hilo secundario
                CoroutineScope(Dispatchers.Main).launch {
                    binding.swDarkmode.isChecked = datosAlmacenados?.darkMode ?: false
                    binding.sonido.isChecked = datosAlmacenados?.sonido ?: false
                    binding.notificaciones.isChecked = datosAlmacenados?.notificaciones ?: true
                    binding.swSincro.isChecked = datosAlmacenados?.sincronizacion ?: true
                    firstTime =! firstTime
                }

            }
        }

        initUI()*/
    }


}