package org.iesch.a08_firebasedam.modelo

data class Tareas(
    var id: String = "",
    var titulo: String = "",
    var descripcion: String = "",
    var  completada: Boolean = false
){
    //Me creo una funcion para convertir esos datos en un Map
    fun toMap(): Map<Any, Any>{
        return mapOf(
            "id" to id,
            "titulo" to titulo,
            "descripcion" to descripcion,
            "completada" to completada
        )
    }
}