package org.iesch.app_MENU_ESTHER

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.AppCompatDelegate
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import com.google.firebase.remoteconfig.remoteConfig
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import org.iesch.app_MENU_ESTHER.apirazas.RazasApiActivity
import org.iesch.app_MENU_ESTHER.calculadora.CalculadoraActivity
import org.iesch.app_MENU_ESTHER.cine.ListaPeliculasActivity
import org.iesch.app_MENU_ESTHER.databinding.ActivityMenuBinding
import org.iesch.app_MENU_ESTHER.datastore.DataStoreActivity
import org.iesch.app_MENU_ESTHER.datastore.DataStoreManager
import org.iesch.app_MENU_ESTHER.edadcanina.EdadCaninaActivity
import org.iesch.app_MENU_ESTHER.fragments.FragmentsActivity
import org.iesch.app_MENU_ESTHER.login.LoginActivity
import org.iesch.app_MENU_ESTHER.login.datastore.LoginDataStoreManager
import org.iesch.app_MENU_ESTHER.maps.MapasActivity
import org.iesch.app_MENU_ESTHER.quizz.QuizzPrincipalActivity
import org.iesch.app_MENU_ESTHER.settings.SettingsActivity
import org.iesch.app_MENU_ESTHER.superheroes.RegistroSuperHeroeActivity

class MenuActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMenuBinding
    private lateinit var loginDataStore: LoginDataStoreManager

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMenuBinding.inflate( layoutInflater )
        setContentView(binding.root)

        aplicarRemoteConfig()
        //Inicializo el DataStore
        loginDataStore = LoginDataStoreManager(this)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Cargo el tema del usuario
        cargarTemaUsuario()

        //Cargo el usuario desde el DataStore
        cargarUsuario()

        configurarMenu()

        aplicarColorRemoteConfig()
    }

    private fun aplicarColorRemoteConfig() {
        // Detectar si está en modo oscuro
        val isNightMode = when (resources.configuration.uiMode and
                android.content.res.Configuration.UI_MODE_NIGHT_MASK) {
            android.content.res.Configuration.UI_MODE_NIGHT_YES -> true
            else -> false
        }

        val colorKey = if (isNightMode) {
            "menu_background_color_dark"
        } else {
            "menu_background_color_light"
        }

        com.google.firebase.Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            val colorDeFondo = com.google.firebase.Firebase.remoteConfig.getString(colorKey)
            if (colorDeFondo.isNotEmpty()) {
                try {
                    binding.main.setBackgroundColor(android.graphics.Color.parseColor(colorDeFondo))
                } catch (e: Exception) {
                    val defaultColor = if (isNightMode) "#FF000000" else "#E8F5E9"
                    binding.main.setBackgroundColor(android.graphics.Color.parseColor(defaultColor))
                    Log.e("MenuActivity", "Error al aplicar color: ${e.message}")
                }
            }
        }
    }

    private fun aplicarRemoteConfig() {
        com.google.firebase.Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            val color = com.google.firebase.Firebase.remoteConfig.getString("menu_background_color")
            if (color.isNotEmpty()) {
                try {
                    binding.root.setBackgroundColor(android.graphics.Color.parseColor(color))
                } catch (e: Exception) {}
            }
        }
    }

    private fun cargarTemaUsuario() {
        lifecycleScope.launch {
            val email = loginDataStore.userEmail.first()
            if (email.isNotEmpty()){
                val dataStoreManager = DataStoreManager(this@MenuActivity, email)
                val modoOscuro = dataStoreManager.modoOscuro.first()

                if (modoOscuro) {
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES)
                } else {
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO)
                }
            }
        }
    }

    private fun cargarUsuario() {
        lifecycleScope.launch {
            val email = loginDataStore.userEmail.first()
            if (email.isNotEmpty()){
                // Obtener el nombre desde Firestore
                try {
                    val db = com.google.firebase.firestore.FirebaseFirestore.getInstance()
                    val document = db.collection("users").document(email).get().await()

                    if (document.exists()) {
                        val nombre = document.getString("nombre") ?: email
                        binding.tvBienvenida.text = "Hola, $nombre"
                    } else {
                        // Si no existe en Firestore, mostrar el email
                        binding.tvBienvenida.text = "Hola, $email"
                    }
                } catch (e: Exception) {
                    // Si hay error, mostrar el email
                    binding.tvBienvenida.text = "Hola, $email"
                    android.util.Log.e("MenuActivity", "Error al cargar usuario: ${e.message}")
                }
            } else {
                binding.tvBienvenida.text = "Hola, Usuario"
            }
        }
    }

    private fun configurarMenu() {
        binding.bntCalculadora.setOnClickListener { irACalculadora() }
        binding.btnEdadCanina.setOnClickListener { irAEdadCanina() }
        binding.btnQuizz.setOnClickListener { irAQuizz() }
        binding.btnSuperheroes.setOnClickListener { irASuperHeroes() }
        binding.btnRazas.setOnClickListener { irARazasActivity() }
        binding.btnCine.setOnClickListener { irAPeliculas() }
        binding.btnSettings.setOnClickListener { irASettings() }
        binding.btnFragments.setOnClickListener { irAMenuFragments() }
        binding.btnMapas.setOnClickListener { irAMapas() }
        binding.btnSalir.setOnClickListener { hacerLogout() } //Boton de salir
        binding.btnUsuario.setOnClickListener { irADataStore() }
    }

    private fun irADataStore() {
        val irADataStore = Intent(this, DataStoreActivity::class.java)
        startActivity(irADataStore)
    }

    private fun irAPeliculas() {
        val intent = Intent(this, ListaPeliculasActivity::class.java)
        startActivity(intent)
    }

    private fun irASettings() {
        val irASettings = Intent(this, SettingsActivity::class.java)
        startActivity(irASettings)
    }

    private fun irAMenuFragments() {
        val irAFragments = Intent(this, FragmentsActivity::class.java)
        startActivity(irAFragments)
    }
    private fun irAEdadCanina() {
        val irAEdadCanina = Intent(this, EdadCaninaActivity::class.java)
        startActivity(irAEdadCanina)
    }
    private fun irASuperHeroes() {
        val irASuperHeroes = Intent(this, RegistroSuperHeroeActivity::class.java)
        startActivity(irASuperHeroes)
    }

    private fun irARazasActivity() {
        val irARazas = Intent(this, RazasApiActivity::class.java)
        startActivity(irARazas)

    }

    private fun irACalculadora() {
        val irACalculadora = Intent(this, CalculadoraActivity::class.java)
        startActivity(irACalculadora)

    }

    private fun irAQuizz() {
        val irAQuizz = Intent(this, QuizzPrincipalActivity::class.java)
        startActivity(irAQuizz)

    }
    private fun irAMapas() {
        val irAMapas = Intent(this, MapasActivity::class.java)
        startActivity(irAMapas)
    }

    private fun hacerLogout(){
        lifecycleScope.launch {
            loginDataStore.logout()
            Toast.makeText(this@MenuActivity, R.string.toastTextCerrarSesion, Toast.LENGTH_LONG).show()
            irALogin()
        }
    }

    private fun irALogin(){
        val irALogin = Intent(this, LoginActivity::class.java)
        //Limpio el stack de actividades para que no se pueda volver atrás
        irALogin.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(irALogin)
        finish()
    }

}



