package org.iesch.app00

var nombre = "Esther"

var num1 = 23
var num2 = 34

fun saludar(){
    print("Hola $nombre")
}

fun sumar(numero1: Int, numero2: Int): Int{
    var res = numero1 + numero2
    return res
}

fun main() {
    //El nombre de las fuciones siempre en camelCase

    saludar()
    sumar(numero1 = num1, numero2 = num2)
}