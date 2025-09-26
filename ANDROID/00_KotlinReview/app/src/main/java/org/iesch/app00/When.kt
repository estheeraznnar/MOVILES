package org.iesch.app00

var mes = 7

fun main() {
    //getMonth(5)

    /*when (mes){
        1 -> print("Enero")
        2 -> print("Febrero")
        3 -> print("Marzo")
        4 -> print("Abril")
        5 -> print("Mayo")
        6 -> print("Junio")
        7 -> print("Julio")
        8 -> print("Agosto")
        9 -> print("Septiembre")
        10 -> print("Octubre")
        11 -> print("Noviembre")
        12 -> print("Diciembre")
    }*/

    res("asdfafaadf")
}

fun getTrimester(mes:Int){
    /*when (mes){
        1, 2, 3 -> print("Primer Trimestre")
        4, 5, 6 -> print("Segundo Trimestre")
        7, 8, 9 -> print("Tercer Trimestre")
        10, 11, 12 -> print("Cuarto Trimestre")
        else -> print("Mes erroneo")
    }*/
}

fun getSemester(mes: Int){
    when (mes){
        /* 1, 2, 3, 4, 5, 6 -> print("Primer Semestre")
         7, 8, 9, 10, 11, 12 -> print("Segundo Semestre")
         else -> print("Mes erroneo")*/

        in 1.. 6 -> print("Primer Semestre")
        in 7.. 12 -> print("Segundo Semestre")
        !in 1..12 -> print("Mes erroneo")
    }
}

fun res(valor: Any){
    when(valor){
        is Int -> valor+ valor
        is String -> print(valor)
    }
}