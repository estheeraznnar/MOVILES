package com.alberto.examen.Pizza.model

import com.google.gson.annotations.SerializedName

data class Pizza(
    @SerializedName("name") val nombre: String,
    @SerializedName("id") val id: String,
    @SerializedName("description") val descripcion: String,
    @SerializedName("imageUrl") val imagen: String
)