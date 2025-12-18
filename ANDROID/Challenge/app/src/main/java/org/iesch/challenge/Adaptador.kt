package org.iesch.challenge

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class Adaptador(private val labels: List<String>) : RecyclerView.Adapter<Adaptador.ViewHolder>() {

    // Clase interna que mantiene las referencias a las vistas de cada fila
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val textView: TextView = view.findViewById(android.R.id.text1)
    }

    // Crea la vista física (infla el XML) cuando el RecyclerView lo solicita
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(android.R.layout.simple_list_item_1, parent, false)
        return ViewHolder(view)
    }

    // Une los datos de la lista con la vista según la posición actual
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.textView.text = labels[position]
    }

    // Indica la cantidad total de elementos a mostrar
    override fun getItemCount() = labels.size
}
