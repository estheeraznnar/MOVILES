package org.iesch.a08_firebasedam

import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.Firebase
import com.google.firebase.auth.auth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.remoteconfig.remoteConfig
import org.checkerframework.checker.interning.qual.Interned
import org.iesch.a08_firebasedam.databinding.ActivityHomeBinding
import java.nio.channels.spi.AsynchronousChannelProvider.provider


enum class ProviderType{
    EMAILYCONTRASENA,
    GOOGLE
}
class HomeActivity : AppCompatActivity() {

    //Creamos una instancia de nuestra base de datos, asi ya la tenemos conectada remotamente
    private val  db = FirebaseFirestore.getInstance()

    lateinit var email : String

    private lateinit var binding: ActivityHomeBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityHomeBinding.inflate( layoutInflater )
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //Recuperamos los valores del usuario
        // Recuperamos los valores del Bundle
        val bundle = intent.extras
        email = bundle?.getString("usuario").toString()
        val provider = bundle?.getString("provider")

        // Lo mostramos en los textview para ello
        binding.emailTextView.text = email.toString()
        binding.metodoTextView.text = provider.toString()
        //Recuperamos nuestra configuracion remota
        configuracionRemota()

        // Listener para el boton de cerrar sesion
        binding.logoutButton.setOnClickListener {
            Firebase.auth.signOut()
            finish()
        }

        binding.optionalButton.setOnClickListener {
            val intent = Intent(this, ListaTareasActivity::class.java)
            startActivity(intent)
        }

        binding.guardarButton.setOnClickListener {
            //Creamos una estructura de daros para guardar en firestore
            //hemos decidido que la clave por cada usuario sea su email
            db.collection("usuarios").document(email).set(
                hashMapOf(
                    "provider" to provider,
                    "email" to email,
                    "direccion" to binding.adressEditText.text.toString(),
                    "telefono" to binding.phoneEditText.text.toString()
                )
            )
        }

        binding.recuperarButton.setOnClickListener {
            //Recuperar los daros de firebase
            db.collection("usuarios").document(email).get().addOnCompleteListener {
                document ->
                if (document != null){
                    binding.adressEditText.setText(document.result.getString("direccion"))
                    binding.phoneEditText.setText(document.result.getString("telefono"))
                    binding.metodoTextView.setText(document.result.getString("provider"))
                }
            }
        }

        binding.eliminarButton.setOnClickListener {
            //Eliminamos los datos de la coleccion
            db.collection("usuarios").document(email).delete()
        }
    }

    private fun configuracionRemota() {
        binding.optionalButton.visibility = View.INVISIBLE
        Firebase.remoteConfig.fetchAndActivate().addOnCompleteListener {
            val showOptionalBottom = Firebase.remoteConfig.getBoolean("show_optional_button")
            val textoBotonOpcional = Firebase.remoteConfig.getString("optional_button_text")
            // Aplicar color de fondo usando la cadena desde Remote Config
            val colorDeFondo = Firebase.remoteConfig.getString("color_bg")

            if (showOptionalBottom){
                binding.optionalButton.visibility = View.VISIBLE
                binding.optionalButton.text = textoBotonOpcional
            }

            val bgColor = resolveColorString(colorDeFondo)
            binding.root.setBackgroundColor(bgColor)
        }
    }

    private fun resolveColorString(colorString: String?): Int {
        if (colorString.isNullOrBlank()) {
            return ContextCompat.getColor(this, android.R.color.background_light)
        }

        val trimmed = colorString.trim()

        // 1) Intentar como recurso en res/color (nombre en colors.xml)
        val colorResId = resources.getIdentifier(trimmed, "color", packageName)
        if (colorResId != 0) {
            return ContextCompat.getColor(this, colorResId)
        }
        // Fallback final
        return ContextCompat.getColor(this, android.R.color.background_light)
    }

}