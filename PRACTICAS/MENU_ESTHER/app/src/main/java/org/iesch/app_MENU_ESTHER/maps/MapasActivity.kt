package org.iesch.app_MENU_ESTHER.maps

import android.graphics.BitmapFactory
import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
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
        //inicializamos el Token
        val mapboxToken = getString(R.string.mapbox_access_token)
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
             }
         }

        //Pngo un marker
        addMarker()
    }

    private fun addMarker() {
        val anotationApi = mapView.annotations
        val pointAnotationManager = anotationApi.createPointAnnotationManager()

        //configurar las opciones del marker
        val bitmap = BitmapFactory.decodeResource(resources, R.drawable.marcker_red)
        mapView.mapboxMap.loadStyle(
            "custom-maker",
            bitmap
        )

        val pointAnnotationOptions = PointAnnotationOptions()
            .withPoint(Point.fromLngLat(-1.097681, 40.327509))
            .withIconImage("custom-maker")
            .withIconSize(1.5)

        pointAnotationManager.create(pointAnnotationOptions)
    }
}