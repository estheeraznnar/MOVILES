package org.iesch.repaso_appi_pizza.model

import com.google.gson.annotations.SerializedName

data class Pizza(
    @SerializedName("id") val id: String,
    @SerializedName("name") val nombre: String,
    @SerializedName("description") val descripcion: String,
    @SerializedName("price") val precio: Double,
    @SerializedName("imageUrl") val imagen: String,
    @SerializedName("category") val categoria: String
)