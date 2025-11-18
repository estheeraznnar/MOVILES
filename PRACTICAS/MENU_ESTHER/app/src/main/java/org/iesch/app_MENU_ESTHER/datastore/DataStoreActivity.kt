package org.iesch.app_MENU_ESTHER.datastore

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.AppCompatDelegate
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.plus
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityDatastoreBinding
import org.iesch.app_MENU_ESTHER.login.datastore.LoginDataStoreManager

class DataStoreActivity : AppCompatActivity() {

    private lateinit var binding: ActivityDatastoreBinding
    private lateinit var dataStoreManager: DataStoreManager
    private lateinit var loginDataStore: LoginDataStoreManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityDatastoreBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.hide()
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Inicializo el LoginDataStore para obtener el  email del usuario
        loginDataStore = LoginDataStoreManager(this)

        //cargo to do lo relacionado con el usuario
        inicializarConUsuario()

    }

    private fun inicializarConUsuario() {
        //Obtengo el email del usuario logueado e inicializo el DataStoreManager
        lifecycleScope.launch {
            val userEmail = loginDataStore.userEmail.first()
            if (userEmail.isEmpty()){
                Toast.makeText(this@DataStoreActivity, "Error no hay usuario logueado", Toast.LENGTH_LONG).show()
                finish()
                return@launch
            }
            //Inicializo el DataStoreManger con el email del usuario
            dataStoreManager = DataStoreManager(this@DataStoreActivity, userEmail)

            //Observo los datos guardados y los muestro en tiempo real
            observarDatosGuardados()

            //Configuro los botones
            configBotones()
        }
    }

    private fun observarDatosGuardados() {
        // Observo el nombre
        lifecycleScope.launch {
            dataStoreManager.nombre.collect { nombre ->
                if (nombre.isEmpty()){
                    binding.tvNombreGuardado.text = "Nombre: No establecido"
                }else{
                    binding.tvNombreGuardado.text = "Nombre: $nombre"
                }
            }
        }

        //Observo la edad
        lifecycleScope.launch {
            dataStoreManager.edad.collect { edad ->
                if (edad == 0){
                    binding.tvEdadGuardada.text = "Edad, no establecida"
                }else{
                    binding.tvEdadGuardada.text = "Edad: $edad"
                }
            }
        }

        //Observo el modo oscuro
        lifecycleScope.launch {
            dataStoreManager.modoOscuro.collect { activo ->
                if (activo){
                    binding.tvModoOscuro.text="Modo Oscuro: Activado"
                }else{
                    binding.tvModoOscuro.text = "Modo oscuro: Desactivado"
                }
                binding.swDarkmode.isChecked = activo
            }
        }

        //Observo las notificaciones
        lifecycleScope.launch {
            dataStoreManager.notificaciones.collect { activo ->
                if (activo){
                    binding.tvNotificaciones.text="Notificaciones activadas"
                }else{
                    binding.tvNotificaciones.text="Notificaciones desactivadas"
                }
                binding.swNotificaciones.isChecked = activo
            }
        }
    }
    private fun configBotones() {
        //Boton Guardar nombre
        binding.btnNombre.setOnClickListener {
            val nombre = binding.nombre.text.toString().trim()

            if (nombre.isEmpty()){
                binding.nombre.error = "El nombre no puede estar vacio"
                return@setOnClickListener
            }

            lifecycleScope.launch {
                dataStoreManager.saveNombre(nombre)
                Toast.makeText(this@DataStoreActivity, "Nombre guardado", Toast.LENGTH_SHORT).show()
                binding.nombre.setText("") //DEspues limpio el campo
            }
        }

        //Boton Guardar Edad
        binding.btnEdad.setOnClickListener {
            val edadStr = binding.edad.text.toString().trim()

            if (edadStr.isEmpty()){
                binding.edad.error="La edad no puede estar vacía."
                return@setOnClickListener
            }

            val edad = edadStr.toIntOrNull()
            if (edad == null || edad <= 0){
                binding.edad.error="Introduce una edad valida"
                return@setOnClickListener
            }

            lifecycleScope.launch {
                dataStoreManager.saveEdad(edad)
                Toast.makeText(this@DataStoreActivity, "Edad guardada correctamente", Toast.LENGTH_SHORT).show()
                binding.edad.setText("") //Limpio el campo
            }
        }

        //Switch Modo Oscuro
        binding.swDarkmode.setOnCheckedChangeListener { _, isChecked ->
            lifecycleScope.launch {
                dataStoreManager.saveModoOscuro(isChecked)
                if (isChecked){
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES)
                }else {
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO)
                }

                Toast.makeText(this@DataStoreActivity,
                    if (isChecked) "Modo oscuro activado" else "Modo claro activado",
                    Toast.LENGTH_SHORT).show()
            }
        }

        //switch notificaciones
        binding.swNotificaciones.setOnCheckedChangeListener { _, isChecked ->
            lifecycleScope.launch {
                dataStoreManager.saveNotificaciones(isChecked)
                Toast.makeText(this@DataStoreActivity, "Notificaciones actualizadas", Toast.LENGTH_SHORT).show()
            }
        }

        binding.btnVolver.setOnClickListener {
            finish() //Cierra la actividad y vuelve al menu
        }
    }
}