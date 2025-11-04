package org.iesch.app_MENU_ESTHER

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.app.Activity
import android.view.animation.ScaleAnimation
import android.widget.ImageView
import org.iesch.app_MENU_ESTHER.login.LoginActivity

//// Activity que muestra el splash screen animado al iniciar la app
class SplashActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        /**
         * OBTENER REFERENCIAS A LOS IMAGEVIEWS
         * Obtiene referencias de los 3 ImageView que contienen los círculos desde el layout
         */
        val circulo1: ImageView = findViewById(R.id.ivCirculo1)
        val circulo2: ImageView = findViewById(R.id.ivCirculo2)
        val circulo3: ImageView = findViewById(R.id.ivCirculo3)

        /**
         * ANIMACIÓN DEL CÍRCULO 1 (exterior - Teal oscuro)
         * Crea una animación de escala que comienza pequeña (0.3f) y termina en tamaño completo (1.0f)
         */
        val anim1 = ScaleAnimation(
            0.3f, 1.0f, 0.3f, 1.0f, //// Escala X: desde 30% hasta 100% y Escala Y: desde 30% hasta 100%
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f, // Centro en el eje X (50% = centro)
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f // Centro en el eje Y (50% = centro)
        ).apply {
            duration = 800 // La animación dura 800ms
            startOffset = 0 // Comienza inmediatamente (en 0ms)
        }

        val anim2 = ScaleAnimation(0.3f, 1.0f, 0.3f, 1.0f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f).apply {
            duration = 700
            startOffset = 400
        }

        val anim3 = ScaleAnimation(0.3f, 1.0f, 0.3f, 1.0f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f).apply {
            duration = 600
            startOffset = 800
        }

        /**
         * CAMBIO DE ACTIVIDAD
         * Después de 2500ms (2.5 segundos), navega a LoginActivity y cierra SplashActivity
         */
        circulo1.startAnimation(anim1)
        circulo2.startAnimation(anim2)
        circulo3.startAnimation(anim3)

        Handler(Looper.getMainLooper()).postDelayed({
            startActivity(Intent(this, LoginActivity::class.java))
            // finish(): cierra SplashActivity para que no vuelva atrás
            finish()
        }, 2500) // Tiempo en milisegundos hasta que se ejecute
    }
}