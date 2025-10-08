package org.iesch.app05.adapter

import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView
import org.iesch.app05.databinding.ItemAndroidVersionBinding
import org.iesch.app05.model.AndroidVersion

//4 - Me configuro el viewHolder
class AndroidVersionViewHolder (val binding: ItemAndroidVersionBinding) : RecyclerView.ViewHolder(binding.root) {

    fun render( androidVersion: AndroidVersion ){
        //Asignamos los datos a las vistas usando binding
        binding.tvNombreVersion.text = androidVersion.nombre
        binding.tvCodigoNombre.text = androidVersion.codigo
        binding.tvDetalles.text = "API ${androidVersion.aplivevel} - ${androidVersion.anoLanzamiento}"

        //Añadimos el click
        itemView.setOnClickListener {
            Toast.makeText(itemView.context, androidVersion.nombre, Toast.LENGTH_LONG).show()
        }
    }

}