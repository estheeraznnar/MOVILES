package com.alberto.examen.Pizza.adapter

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.alberto.examen.databinding.ActivityEjercicio3Binding
import com.alberto.examen.Pizza.model.Pizza
import com.squareup.picasso.Picasso
import com.alberto.examen.R

// Esta clase recibirá la vista que vamos a pintar
class PizzaViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    private val binding = ActivityEjercicio3Binding.bind(view)

    fun render(pizza: Pizza) {
        binding.tvNombrePizza.text = pizza.nombre
        binding.tvDescripcionPizza.text = pizza.descripcion

        // Cargar imagen con Picasso
        Picasso.get()
            .load(pizza.imagen)
            .placeholder(R.mipmap.ic_launcher)
            .error(R.mipmap.ic_launcher)
            .into(binding.ivPizza)
    }
}