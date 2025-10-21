package org.iesch.app03.apirazas.adapter

import android.net.wifi.rtt.RangingRequest
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import org.iesch.app03.R

//02- Nuestro adaptador recibira una lista de strings, le ptendremos q pasar el ViewHolder
class DogAdapter (val images : List<String>) : RecyclerView.Adapter<DogViewHolder>(){
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): DogViewHolder {
        //07- Aqui tendremos que inflar el layout del item que nos hemos creado para cada respuesta
        val layoutInflater = LayoutInflater.from(parent.context)
        return DogViewHolder(layoutInflater.inflate(R.layout.item_dog, parent, false))
    }

    override fun onBindViewHolder(
        holder: DogViewHolder,
        position: Int
    ) {
       //06- Creamos el item que sera la imagen y la posicion que tenga
        //llamamos al holder y le pasamos el item
        val item = images[position]
        holder.rander(item)
    }

    override fun getItemCount(): Int {
        //05- Devolvera el tamaño  de la lista que tengamos
        return images.size
    }


}