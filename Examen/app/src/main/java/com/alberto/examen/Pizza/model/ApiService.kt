package com.alberto.examen.Pizza.model

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Url

interface ApiService {
    @GET("pizzas")
    suspend fun getPizzas(@Url image: String): Response<PizzaResponse>


}