package org.iesch.a02_registro_superheroes

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.health.connect.datatypes.units.Power
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.widget.ImageView
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.iesch.a02_registro_superheroes.databinding.ActivityRegisterBinding
import org.iesch.a02_registro_superheroes.detalle.DetalleHeroeActivity
import org.iesch.a02_registro_superheroes.model.SuperHeroe
import java.io.File
import java.nio.file.Files

class RegisterActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRegisterBinding
    private lateinit var heroImage: ImageView

    //9. Creamos una variable que va a manejar el resultado de haber hecho la foto
    private var heroBitmap: Bitmap? = null

    private var picturePath = ""
    //01- Cambiamos el TakePictureView por TakePikture
    private var getContent = registerForActivityResult(ActivityResultContracts.TakePicture()){
        //Ahora en lugar de un bitmap nos va a devolver un booleano si la toma de la foto es inexistente
        success ->
        if (success && picturePath.isNotEmpty()) {
            //Cualquier imagen del directorio de la imagen la podemos convertir en un bitmap
            heroBitmap = BitmapFactory.decodeFile(picturePath)
            ///Pintamos la imagen en el cuadrado
            heroImage.setImageBitmap(heroBitmap)
        }

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        binding.btnGuardar.setOnClickListener {
            // Nos creamos las variables necesarias para pasarlas al Intent
            val superHeroName = binding.etHeroName.text.toString()
            val alterEgo = binding.etAlterEgo.text.toString()
            val bio = binding.etBio.text.toString()
            val power = binding.rbPower.rating

            //7. me creo un objeto superheroe y se lo envio a la funcion irADetalle
            val  superHeroe = SuperHeroe(superHeroName, alterEgo, bio, power)

            irADetalleHeroe( superHeroe )

        }

        //10.
        heroImage = binding.superheroImage
        binding.superheroImage.setOnClickListener {
            openCamera()
        }
    }

    private fun openCamera() {
        //02- Ahora a qui debemos crear un path temporal para guardar la imagen
        val imagefile = createImageFile()
        //04- Ahora ya tenemos el File, pero lo que necesitamos es el uri
        //como estamos por encima de la SDK 24 obtenemos el Uri a traves de FileProvier
        //FileProvider lo que hace es compartir el file con ptras aplicaciones de forma segura
        val uri = FileProvider.getUriForFile(
            this,
            "${applicationContext.packageName}.provider",
            imagefile
        )
        //05- Ahora le pasamos el uri a la funcion launcher
        getContent.launch(uri)

    }

    //03- Esta funcion crea un file y de ese file recuperamos el uri
    private fun createImageFile() : File {
        val fileName = "superhero_name"
        //Esto sera el directorio donde vamos a almacenar la imagen, por defecto es Directore_picture
        val fileDirectory = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        //creamos nuestro file, y aqui nos pide el nombre, el formato, y el directorio
        val imageFile = File.createTempFile(fileName, ".jpg", fileDirectory)
        //Ahora ya podemos guardar el path en la variable global
        picturePath = imageFile.absolutePath
        return imageFile
        
    }

    private fun irADetalleHeroe( superHeroe: SuperHeroe ) {
        // El intent debe tener muy claro desde dónde se le llama y a dónde va
        val intent = Intent(this, DetalleHeroeActivity::class.java)

        // Añado los valores al Intent con la función putExtra
        /*intent.putExtra(DetalleHeroeActivity.HERO_NAME, superHeroName)
        intent.putExtra(DetalleHeroeActivity.ALTER_EGO, alterEgo)
        intent.putExtra(DetalleHeroeActivity.BIO,bio)
        intent.putExtra(DetalleHeroeActivity.POWER, power)*/
        intent.putExtra(DetalleHeroeActivity.superHeroe_KEY, superHeroe)
        //07- Pasamos solamente el picturePath
        intent.putExtra(DetalleHeroeActivity.FOTO_KEY, picturePath)
        startActivity(intent)
    }
}