package org.iesch.app03.fragments

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import org.iesch.app03.R
import org.iesch.app03.databinding.ActivityFragmentsBinding
import org.iesch.app03.fragments.fragmentos.HomeProfileFragment
import org.iesch.app03.fragments.fragmentos.ProfileFragment
import org.iesch.app03.fragments.fragmentos.SettingsFragment

class FragmentsActivity : AppCompatActivity() {
    private lateinit var binding: ActivityFragmentsBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityFragmentsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //06- Me muestro el fragmento por defecto
        replaceFragment(HomeProfileFragment())

        binding.bottomnavigation.setOnItemSelectedListener {
            when( it.itemId){
                R.id.menu_inicio -> {
                    replaceFragment(HomeProfileFragment())
                    true
                }
                R.id.menu_perfil -> {
                    replaceFragment(ProfileFragment())
                    true
                }
                R.id.menu_herramientas -> {
                    replaceFragment(SettingsFragment())
                    true
                }
                else -> false
            }
        }
    }

    //01- Me creo una funcion para remplazar los fragments
    private fun replaceFragment(fragment: Fragment){
        //02- Creo las variables para manejar los fragmentos
        val fragmentManager = supportFragmentManager
        //03-Creo la transaccion
        val transaction = fragmentManager.beginTransaction()
        //04- Reemplazo el fragment que haya
        transaction.replace(R.id.frame_layout, fragment)
        //05- confirmamos la transaccion
        transaction.commit()
    }
}