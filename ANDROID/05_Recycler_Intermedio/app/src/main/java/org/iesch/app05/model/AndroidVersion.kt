package org.iesch.app05.model

//1 - Creamos el modelo de datos
//Uso data class
data class AndroidVersion (
    val nombre: String,
    val codigo: String,
    val aplivevel: Int,
    val anoLanzamiento: Int
)