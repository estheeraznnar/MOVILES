package org.iesch.app03.apirazas.adapter

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import org.iesch.app03.databinding.ItemDogBinding

class DogViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    //04 - Creamos el metodo que recibira una imagen por cada celda que tenemos que pintar
    private val binding = ItemDogBinding.bind(view)
    fun rander(imagen : String){
        //08- Atraves de la libreria picasso mostraremos la imagen a partir de la url
        Picasso.get().load(imagen).into(binding.ivDog)
    }

}