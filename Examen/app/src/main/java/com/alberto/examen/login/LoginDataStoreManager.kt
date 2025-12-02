package com.alberto.examen.login

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
/*import com.mapbox.common.experimental.wss_backend.Data*/
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import okhttp3.FormBody

// Extensión para crear el DataStore llamado "loginDB" como pide la práctica
private val Context.loginDataStore: DataStore<Preferences> by preferencesDataStore(name = "loginDB")

class LoginDataStoreManager(private val context: Context) {

    //Creo un companion object con las claves para almacenar los datos
    companion object{
        private val  EMAIL_KEY = stringPreferencesKey("user_email")

        private val  IS_LOGGERD_KEY = booleanPreferencesKey("is_logged")

    }

    //Funcion para guardar el email y la contraseña cuando el usuario hace login y el tipo de login
    suspend fun saveLoginData(email: String, passwd: String = "firebase"){
        context.loginDataStore.edit { preferences ->
            preferences[EMAIL_KEY] = email
            preferences[IS_LOGGERD_KEY] = true

        }
    }


    //Hago un flow para observar si el usuario esta logeado o no
    val isLogger: Flow<Boolean> = context.loginDataStore.data.map { preferences ->
        preferences[IS_LOGGERD_KEY] ?: false
    }

    //Un flow para obtener el email guardado
    val userEmail: Flow<String> = context.loginDataStore.data.map { preferences ->
        preferences[EMAIL_KEY] ?: ""
    }


}