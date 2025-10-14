package org.iesch.app03.apirazas.model

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Url

//2 - Creamos la interfaz, la cual contendra el metodo (o los metodos)
//por los cuales queremos consumir nuestro API

interface APIService {

    //3 - Aqui usare Retrofi y lo que he de poner es el tipo de operacion que realizo
    //4 - Esta funcion recibira por parametro algo, una direccion + home/images,
    //y devolvera un objeto de tipo DogsResponse
    @GET
    fun getPerrosPorRaza( @Url url: String ) : Response<DogsResponse>
}