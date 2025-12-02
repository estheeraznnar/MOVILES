package org.iesch.repaso_appi_pizza.model

import com.google.gson.annotations.SerializedName

// Completa esta clase
// Cambiamos para que coincida con la API real
data class PizzaResponse(
    @SerializedName("pizzas") val pizzas: List<Pizza>
)