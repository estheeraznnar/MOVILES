package org.iesch.challenge

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.os.Environment
import android.util.Log
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.label.ImageLabeling
import com.google.mlkit.vision.label.defaults.ImageLabelerOptions
import org.iesch.challenge.databinding.ActivityMainBinding
import java.io.File

class MainActivity : AppCompatActivity() {

    // ViewBinding para acceder a los componentes del XML sin findViewById
    private lateinit var binding: ActivityMainBinding
    private lateinit var imagen: ImageView

    private var picturePath = "" // Ruta absoluta de la foto tomada
    private var bitmap: Bitmap? = null // Objeto de la imagen en memoria

    // Registra el contrato para tomar fotos. Retorna true si se guardó la imagen.
    private val getContent = registerForActivityResult(ActivityResultContracts.TakePicture()){ success ->
        if (success && picturePath.isNotEmpty()) {
            bitmap = BitmapFactory.decodeFile(picturePath) // Convierte archivo a Bitmap
            imagen.setImageBitmap(bitmap) // Muestra la foto en el ImageView
            bitmap?.let { analizarImagen(it) } // Llama a la IA inmediatamente
        }
    }

    // Registra el contrato para abrir la galería y obtener una URI de imagen
    private val getGalleryContent = registerForActivityResult(ActivityResultContracts.GetContent()) { uri ->
        uri?.let {
            imagen.setImageURI(it) // Muestra la imagen seleccionada
            val inputStream = contentResolver.openInputStream(it)
            bitmap = BitmapFactory.decodeStream(inputStream) // Decodifica la URI a Bitmap
        }
    }

    // Maneja la petición de permisos de cámara en tiempo de ejecución
    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()) { isGranted ->
        if (isGranted) openCamera() // Si acepta, abre la cámara
    }

    // Configuración opcional del etiquetador (Umbral de confianza del 50%)
    val options = ImageLabelerOptions.Builder()
        .setConfidenceThreshold(0.5f)
        .build()
    val labeler = ImageLabeling.getClient(options)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge() // Habilita diseño de pantalla completa
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Ajuste automático de paddings para evitar que el contenido tape barras del sistema
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        imagen = binding.image

        // Al pulsar la imagen, muestra menú para elegir entre Cámara o Galería
        binding.image.setOnClickListener {
            val opciones = arrayOf("Hacer foto", "Elegir de galería")
            val builder = android.app.AlertDialog.Builder(this)
            builder.setTitle("Selecciona una opción")
            builder.setItems(opciones) { _, which ->
                when (which) {
                    0 -> requestPermissionLauncher.launch(android.Manifest.permission.CAMERA)
                    1 -> getGalleryContent.launch("image/*")
                }
            }
            builder.show()
        }

        // Botón "Enviar" para analizar la imagen manualmente
        binding.enviar.setOnClickListener {
            bitmap?.let { analizarImagen(it) } ?: run {
                Toast.makeText(this, "Por favor, selecciona una foto primero", Toast.LENGTH_SHORT).show()
            }
        }
    }

    // Prepara el archivo y lanza la cámara
    private fun openCamera() {
        val imageFile = createImageFile()
        val uri = FileProvider.getUriForFile(
            this,
            "${applicationContext.packageName}.provider", // Debe coincidir con el AndroidManifest
            imageFile
        )
        getContent.launch(uri)
    }

    // Crea un archivo .jpg temporal en el almacenamiento privado de la app
    private fun createImageFile() : File {
        val fileName = "image"
        val fileDirectory = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        val imageFile = File.createTempFile(fileName, ".jpg", fileDirectory)
        picturePath = imageFile.absolutePath // Guarda la ruta para el BitmapFactory
        return imageFile
    }

    // Procesa la imagen con ML Kit para detectar qué objetos aparecen
    private fun analizarImagen(bitmap: Bitmap) {
        val image = InputImage.fromBitmap(bitmap, 0)
        val labeler = ImageLabeling.getClient(ImageLabelerOptions.DEFAULT_OPTIONS)

        labeler.process(image)
            .addOnSuccessListener { labels ->
                // Mapea los resultados a una lista de Strings "Etiqueta (Confianza%)"
                val resultados = labels.map { "${it.text} (${(it.confidence * 100).toInt()}%)" }
                // Envía los datos al RecyclerView a través de su adaptador
                binding.labeled.adapter = Adaptador(resultados)
            }
            .addOnFailureListener { e -> Log.e("MLKit", "Error: ${e.message}") }
    }
}