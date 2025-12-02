package com.alberto.examen.Pizza.model

import com.google.gson.annotations.SerializedName

//Cambio para que coincida con la API real
data class PizzaResponse(
    @SerializedName("pizzas") val pizzas: List<Pizza>
)