package org.iesch.a08_firebasedam.recycler

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import android.graphics.Color
import org.iesch.a08_firebasedam.databinding.ItemTareasBinding
import org.iesch.a08_firebasedam.modelo.Tareas

//Creamos el adaptador
class TareaAdaptador (
    private var listaTareas: MutableList<Tareas>,
    private val onBorrar: ((Tareas) -> Unit )? = null,
    private val onToogleCompletada: ((Tareas) -> Unit )? = null,
): RecyclerView.Adapter<TareaViewHolder>(){

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): TareaViewHolder {
        //por ultimo este
        //Inflo el layput del item
        val binding = ItemTareasBinding
            .inflate(LayoutInflater
                .from(parent.context), parent, false)

        //devolvemos el ViewHolder
        return TareaViewHolder(binding)
    }


    override fun onBindViewHolder(
        holder: TareaViewHolder,
        position: Int
    ) {
        //Luego este
        //Llamo al bind del ViewHolder
        holder.bind( listaTareas[position], onBorrar, onToogleCompletada )
    }

    override fun getItemCount(): Int {
        // primero este
        return listaTareas.size
    }

    fun actuaLizarlista(nuevaLista: MutableList<Tareas>){
        listaTareas = nuevaLista
        notifyDataSetChanged()
    }

}

// Me creo el view holder
class TareaViewHolder( private  val binding: ItemTareasBinding ) : RecyclerView.ViewHolder(binding.root){

    fun bind(
        tarea: Tareas,
        onBorrar: ((Tareas) -> Unit)? = null,
        onToogleCompletada: ((Tareas) -> Unit)? = null
    ){
        binding.tvTitulo.text = tarea.titulo
        binding.tvDescripcion.text = tarea.descripcion
        // Pongo a true o false el check que he añadido en base a lo que valga
        binding.swCompletada.setOnCheckedChangeListener(null)
        binding.swCompletada.isChecked = tarea.completada

        aplicarEstiloCompletada( tarea.completada )
        binding.swCompletada.setOnCheckedChangeListener { _, isChecked ->
            //actualizamos el valor del objeto
            tarea.completada = isChecked
            aplicarEstiloCompletada(isChecked)
            onToogleCompletada?.invoke(tarea)
        }

        binding.imgBtnBorrar.setOnClickListener {
            onBorrar?.invoke(tarea)
        }
    }

    private fun aplicarEstiloCompletada( completada: Boolean) {
        if ( completada ) {
            binding.card.setBackgroundColor(Color.parseColor("#a8cc94"))
        } else {
            binding.card.setBackgroundColor(Color.parseColor("#F0BFBB"))
        }
    }
}