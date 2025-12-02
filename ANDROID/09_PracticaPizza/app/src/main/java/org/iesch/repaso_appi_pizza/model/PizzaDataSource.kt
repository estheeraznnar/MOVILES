package org.iesch.repaso_appi_pizza.model

object PizzaDataSource {

    fun getPizzasMock(): List<Pizza> {
        return listOf(
            Pizza(
                id = "1",
                nombre = "Margherita",
                descripcion = "Tomate, mozzarella y albahaca fresca",
                precio = 8.50,
                imagen = "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400",
                categoria = "clasica"
            ),
            Pizza(
                id = "2",
                nombre = "Pepperoni",
                descripcion = "Salsa de tomate, mozzarella y pepperoni",
                precio = 10.50,
                imagen = "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400",
                categoria = "clasica"
            ),
            Pizza(
                id = "3",
                nombre = "Cuatro Quesos",
                descripcion = "Mozzarella, gorgonzola, parmesano y provolone",
                precio = 11.50,
                imagen = "https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?w=400",
                categoria = "especial"
            ),
            Pizza(
                id = "4",
                nombre = "Hawaiana",
                descripcion = "Jamón, piña y mozzarella",
                precio = 9.50,
                imagen = "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400",
                categoria = "clasica"
            ),
            Pizza(
                id = "5",
                nombre = "Barbacoa",
                descripcion = "Pollo, bacon, cebolla y salsa barbacoa",
                precio = 12.00,
                imagen = "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400",
                categoria = "especial"
            ),
            Pizza(
                id = "6",
                nombre = "Vegetariana",
                descripcion = "Pimientos, champiñones, cebolla y aceitunas",
                precio = 9.00,
                imagen = "https://images.unsplash.com/photo-1511689660979-10d2b1aada49?w=400",
                categoria = "vegetariana"
            ),
            Pizza(
                id = "7",
                nombre = "Diavola",
                descripcion = "Salami picante, chile y mozzarella",
                precio = 10.00,
                imagen = "https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=400",
                categoria = "picante"
            ),
            Pizza(
                id = "8",
                nombre = "Napolitana",
                descripcion = "Anchoas, alcaparras, tomate y orégano",
                precio = 11.00,
                imagen = "https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?w=400",
                categoria = "clasica"
            ),
            Pizza(
                id = "9",
                nombre = "Prosciutto",
                descripcion = "Jamón serrano, rúcula y parmesano",
                precio = 13.50,
                imagen = "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400",
                categoria = "especial"
            ),
            Pizza(
                id = "10",
                nombre = "Funghi",
                descripcion = "Champiñones frescos, ajo y trufa",
                precio = 12.50,
                imagen = "https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=400",
                categoria = "vegetariana"
            )
        )
    }

    fun getPizzasPorCategoria(categoria: String): List<Pizza> {
        return getPizzasMock().filter {
            it.categoria.equals(categoria, ignoreCase = true)
        }
    }
}