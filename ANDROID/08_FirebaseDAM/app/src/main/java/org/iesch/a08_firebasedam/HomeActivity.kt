package org.iesch.a08_firebasedam

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.Firebase
import com.google.firebase.auth.auth
import org.iesch.a08_firebasedam.databinding.ActivityHomeBinding

enum class ProviderType{
    EMAIL_CONTRASEÑA,
    GOOGLE

}
class HomeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityHomeBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityHomeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Recuperamos los valores del bundle
        val bundle = intent.extras
        val email = bundle?.getString("usuario")
        val provider = bundle?.getString("provider")

        //lo mostramos en los text view poara ello
        binding.emailTextView.text = email
        binding.metodoTextView.text = provider

        //Listener para cerrar sesion
        binding.logoutButton.setOnClickListener {
            Firebase.auth.signOut()
            finish()
        }
    }
}