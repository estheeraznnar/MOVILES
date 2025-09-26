package org.iesch.app00

var weekDay = arrayOf("Lunes", "Martes", "Miercoles",
    "Jueves", "Viernes", "Sabado", "Domingo")

fun main() {
    print(weekDay) //os muuestra la direccion de la memoria
    print(weekDay[2])
    print(weekDay.size)
    weekDay[2] = "Hoy es miercoles" //Le ouedo cambiar el valor a un array
    print(weekDay[2])

    //Recorrer el array
    /*for (position in weekDay.indices){
        print(weekDay[position])
    }

    for ((position, value ) in weekDay.withIndex()){
        println("La posicion $position contiene $value")
    }

    for (valor in weekDay){
        println("El dia es $valor")
    }*/

    weekDay.forEach { dia -> print(dia) }
}