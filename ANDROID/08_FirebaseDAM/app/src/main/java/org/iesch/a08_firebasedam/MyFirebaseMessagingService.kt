package org.iesch.a08_firebasedam

import android.app.Service
import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {
    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        Log.d("FCM", "Mensaje recibido: ${message.from}")

        //Mostrar la notificacion
        message.notification?.let {
            Log.d("FCM", "Titulo: ${it.title}")
            Log.d("FCM", "Cuerpo: ${it.body}")
        }
    }
}
