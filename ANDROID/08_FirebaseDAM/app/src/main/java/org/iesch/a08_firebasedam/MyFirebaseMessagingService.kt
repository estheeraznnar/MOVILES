package org.iesch.a08_firebasedam

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Log.d("FCM", "Nuevo token de FCM: $token")
        // Aquí puedes enviar el token a tu servidor si lo necesitas
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        Log.d("FCM", "Mensaje recibido de: ${message.from}")

        // Mostrar notificación
        message.notification?.let {
            Log.d("FCM", "Título: ${it.title}")
            Log.d("FCM", "Cuerpo: ${it.body}")
            //mostrarNotificacion(it.title ?: "Notificación", it.body ?: "")
            // Lo mostraremos mediante un Toast
            Handler(Looper.getMainLooper()).post {

                //Toast.makeText(this, message.notification?.title, Toast.LENGTH_LONG).show()
                val intent = Intent(this, LoginActivity::class.java).apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                }
                val pendingIntent = PendingIntent.getActivity(
                    this,
                    0,
                    intent,
                    PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                )

                val toast = android.widget.Toast.makeText(
                    applicationContext,
                    "Título: ${it.title}\nCuerpo: ${it.body}",
                    android.widget.Toast.LENGTH_LONG
                )
                toast.show()
            }
            //Looper.loop()
        }

        // Datos adicionales
        if (message.data.isNotEmpty()) {
            Log.d("FCM", "Datos recibidos: ${message.data}")
        }
    }

    private fun mostrarNotificacion(titulo: String, mensaje: String) {
        val channelId = "firebase_notifications"
        val notificationId = System.currentTimeMillis().toInt()

        // Intent para abrir la app al hacer clic
        val intent = Intent(this, LoginActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        // Crear notificación
        val notification = NotificationCompat.Builder(this, channelId)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setContentTitle(titulo)
            .setContentText(mensaje)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Crear canal de notificación para Android 8.0+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                "Notificaciones Firebase",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Canal para notificaciones de Firebase"
            }
            notificationManager.createNotificationChannel(channel)
        }

        notificationManager.notify(notificationId, notification)
        Log.d("FCM", "Notificación mostrada: $titulo - $mensaje")
    }

}
