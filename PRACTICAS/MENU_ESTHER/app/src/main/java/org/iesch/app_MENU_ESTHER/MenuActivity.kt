package org.iesch.app_MENU_ESTHER

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch
import org.iesch.app_MENU_ESTHER.apirazas.RazasApiActivity
import org.iesch.app_MENU_ESTHER.calculadora.CalculadoraActivity
import org.iesch.app_MENU_ESTHER.cine.ListaPeliculasActivity
import org.iesch.app_MENU_ESTHER.databinding.ActivityMenuBinding
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

        //Inicializo el DataStore
        loginDataStore = LoginDataStoreManager(this)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        val correo = intent.getStringExtra("correo_usuario")
        binding.tvBienvenida.text = "Hola, $correo"

        configurarMenu()
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
        //Boton de salir
        binding.btnSalir.setOnClickListener { hacerLogout() }
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



