package org.iesch.app_MENU_ESTHER.maps

import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.graphics.createBitmap
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.mapbox.geojson.Point
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.MapView
import com.mapbox.maps.Style
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager
import org.iesch.app_MENU_ESTHER.R
import org.iesch.app_MENU_ESTHER.databinding.ActivityMapasBinding
import org.iesch.app_MENU_ESTHER.databinding.ActivityMenuBinding

class MapasActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMapasBinding
    private lateinit var mapView: MapView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityMapasBinding.inflate( layoutInflater )
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        //Iniciamos el mapa
        mapView = binding.mapView


        //Configuramos el mapa y el estilo del mapa
         mapView.mapboxMap.apply {
             //Cargamos el estilo del mapa
             loadStyle(Style.MAPBOX_STREETS){
                 style ->
                 //configuramos la ibicacion inicial del mapa
                 setCamera(
                     CameraOptions.Builder()
                         .center(Point.fromLngLat(-1.097681, 40.327509))
                         .zoom(16.0)
                         .build()
                 )

                 //Cargar y añadir la imagen del marcador al estilo
                 val drawable = ContextCompat.getDrawable(this@MapasActivity, R.drawable.marcker_red)
                 val bitmap = createBitmap(drawable!!.intrinsicWidth, drawable.intrinsicHeight)
                 val canvas = Canvas(bitmap)
                 drawable.setBounds(0, 0, canvas.width, canvas.height)
                 drawable.draw(canvas)

                 style.addImage("custom-marker", bitmap)

                 //Crear el marcador despues de que el estilo este cargado
                 val anotationApi = mapView.annotations
                 val pointAnnotationManager = anotationApi.createPointAnnotationManager()

                 val pointAnnotationOptions = PointAnnotationOptions()
                     .withPoint(Point.fromLngLat(-1.097681, 40.327509))
                     .withIconImage("custom-maker")
                     .withIconSize(1.5)

                 pointAnnotationManager.create(pointAnnotationOptions)
             }
         }
    }
}