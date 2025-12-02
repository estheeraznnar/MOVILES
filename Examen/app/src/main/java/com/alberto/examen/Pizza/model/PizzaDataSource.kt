package com.alberto.examen.Pizza.model

object PizzaDataSource {

    fun getPizzasMock(): List<Pizza> {
        return listOf(
            Pizza(
                nombre = "Margherita",
                id = "1",
                descripcion = "Deliciosa pizza hecha con masa italiana, queso mozzarella, albahaca fresca, salsa de tomate y aceite de oliva extra.",
                imagen = "https://www.codingpizza.com/wp-content/uploads/2018/12/margherita.jpg"
            ),
            Pizza(
                nombre = "Cuatro Quesos",
                id = "2",
                descripcion = "Exquisita pizza hecha con salsa de tomate,queso mozzarella,queso azulmqueso parmesano y queso de cabra",
                imagen = "https://www.codingpizza.com/wp-content/uploads/2018/12/quattro-formaggi.jpg"
            ),
            Pizza(
                nombre = "Diavola",
                id = "3",
                descripcion = "Para los mas valientes, pizza hecha con salsa  de tomate,mozzarella,aceite de oliva,salsicha picante,oregano y cebolla.",
                imagen = "https://www.codingpizza.com/wp-content/uploads/2018/12/diavola.jpg"
            ),
            Pizza(
                nombre = "Pizza Capricciosa",
                id = "4",
                descripcion = "Se pronuncia 'Caprichiosa' no 'Capriquiosa'. Hecha con salsa de tomate, mozzarella,hongos,alcachofa,prosciutto crudo y olivas negras ",
                imagen = "https://www.codingpizza.com/wp-content/uploads/2018/12/capricciosa.jpg"
            )
        )
    }

}