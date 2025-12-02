package org.iesch.repaso_appi_pizza.model

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface PizzaApiService {
    @GET("pizzas")
    suspend fun getPizzas(): Response<PizzaResponse>

    @GET("pizzas/{categoria}")
    suspend fun getPizzasPorCategoria(@Path("categoria") categoria: String): Response<PizzaResponse>
}