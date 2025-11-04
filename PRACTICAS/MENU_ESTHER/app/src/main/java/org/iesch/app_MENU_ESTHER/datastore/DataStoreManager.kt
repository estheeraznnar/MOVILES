package org.iesch.app_MENU_ESTHER.datastore

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

//Extension para crear el DataStore
private val Context.settingsDataStore: DataStore<Preferences> by preferencesDataStore(name = "settings_preferences")
class DataStoreManager(private val context: Context, private val userEmail: String) {

     private val NOMBRE_KEY = stringPreferencesKey("${userEmail}nombre_usuario")
     private val EDAD_KEY = intPreferencesKey("${userEmail}edad_usuario")
     private val NOTIFICACIONES_KEY = booleanPreferencesKey("${userEmail}notificaciones")
     private val MODO_OSCURO_KEY = booleanPreferencesKey("${userEmail}modo_oscuro")


    //funciones para guardar datos
    suspend fun saveNombre(nombre: String){
        context.settingsDataStore.edit { preferences ->
            preferences[NOMBRE_KEY] = nombre
        }
    }

    suspend fun saveEdad(edad: Int){
        context.settingsDataStore.edit { preferences ->
            preferences[EDAD_KEY] = edad
        }
    }

    suspend fun saveNotificaciones(activas: Boolean){
        context.settingsDataStore.edit { preferences ->
            preferences[NOTIFICACIONES_KEY] = activas
        }
    }
    suspend fun saveModoOscuro(activo: Boolean){
        context.settingsDataStore.edit { preferences ->
            preferences[MODO_OSCURO_KEY] = activo
        }
    }

    //Flows para leer los datos guardados
    val nombre: Flow<String> = context.settingsDataStore.data.map { preferences ->
        preferences[NOMBRE_KEY] ?: ""
    }

    val edad: Flow<Int> = context.settingsDataStore.data.map { preferences ->
        preferences[EDAD_KEY] ?: 0
    }

    val notificaciones: Flow<Boolean> = context.settingsDataStore.data.map { preferences ->
        preferences[NOTIFICACIONES_KEY] ?: true
    }

    val modoOscuro: Flow<Boolean> = context.settingsDataStore.data.map { preferences ->
        preferences[MODO_OSCURO_KEY] ?: false
    }

}

