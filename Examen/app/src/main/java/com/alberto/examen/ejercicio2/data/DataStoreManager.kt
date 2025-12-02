package com.alberto.examen.ejercicio2.data

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

     private val TEXTO_KEY = stringPreferencesKey("${userEmail}texto")
     private val NOTIFICACIONES_KEY = booleanPreferencesKey("${userEmail}notificaciones")
     private val MODO_OSCURO_KEY = booleanPreferencesKey("${userEmail}modo_oscuro")
     private val SONIDO_KAY = booleanPreferencesKey("${userEmail}sonido")
     private val SINCRONIZACION_KAY = booleanPreferencesKey("${userEmail}sincronizacion")


    //funciones para guardar datos
    suspend fun savetexto(texto: String){
        context.settingsDataStore.edit { preferences ->
            preferences[TEXTO_KEY] = texto
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
    suspend fun saveSonido(activo: Boolean){
        context.settingsDataStore.edit { preferences ->
            preferences[SONIDO_KAY] = activo
        }
    }
    suspend fun saveSincronizacion(activo: Boolean){
        context.settingsDataStore.edit { preferences ->
            preferences[SINCRONIZACION_KAY] = activo
        }
    }

    //Flows para leer los datos guardados
    val texto: Flow<String> = context.settingsDataStore.data.map { preferences ->
        preferences[TEXTO_KEY] ?: ""
    }

    val notificaciones: Flow<Boolean> = context.settingsDataStore.data.map { preferences ->
        preferences[NOTIFICACIONES_KEY] ?: false
    }

    val sonido: Flow<Boolean> = context.settingsDataStore.data.map { preferences ->
        preferences[SONIDO_KAY] ?: false
    }
    val sincronizacion: Flow<Boolean> = context.settingsDataStore.data.map { preferences ->
        preferences[SINCRONIZACION_KAY] ?: false
    }

}

