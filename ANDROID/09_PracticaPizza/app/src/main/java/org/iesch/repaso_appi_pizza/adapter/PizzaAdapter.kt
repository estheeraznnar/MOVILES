package org.iesch.repaso_appi_pizza.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import org.iesch.repaso_appi_pizza.model.Pizza
import org.iesch.repaso_appi_pizza.R


// Ahora recibe una lista de Strings (URLs)
class PizzaAdapter(val pizzas: List<Pizza>) :
    RecyclerView.Adapter<PizzaViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PizzaViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        return PizzaViewHolder(
            layoutInflater.inflate(R.layout.item_pizza, parent, false)
        )
    }

    override fun onBindViewHolder(holder: PizzaViewHolder, position: Int) {
        val item = pizzas[position]
        holder.render(item)
    }

    override fun getItemCount(): Int = pizzas.size
}
