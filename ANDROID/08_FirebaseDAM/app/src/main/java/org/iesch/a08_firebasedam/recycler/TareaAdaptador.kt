package org.iesch.a08_firebasedam.recycler

import androidx.recyclerview.widget.RecyclerView
import org.iesch.a08_firebasedam.databinding.ItemTareasBinding
import org.iesch.a08_firebasedam.modelo.Tareas

//Creamos el adaptador
class TareaAdaptador (
    private val listaTareas: MutableList<Tareas>
): RecyclerView.ViewHolder<TareaAdaptador.TareaViewHolder>{

    class TareaViewHolder(private val binding: ItemTareasBinding): RecyclerView.ViewHolder(binding.root) {

    }

}