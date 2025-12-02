package com.alberto.examen.Pizza.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.alberto.examen.Pizza.model.Pizza
import com.alberto.examen.R

// Ahora recibe una lista de Strings (URLs)
class PizzaAdapter(val pizzas: List<Pizza>) :
    RecyclerView.Adapter<PizzaViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PizzaViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        return PizzaViewHolder(
            layoutInflater.inflate(R.layout.activity_ejercicio3, parent, false)
        )
    }

    override fun onBindViewHolder(holder: PizzaViewHolder, position: Int) {
        val item = pizzas[position]
        holder.render(item)
    }

    override fun getItemCount(): Int = pizzas.size
}