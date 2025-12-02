package org.iesch.repaso_appi_pizza.adapter

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import org.iesch.repaso_appi_pizza.databinding.ItemPizzaBinding
import org.iesch.repaso_appi_pizza.model.Pizza
import org.iesch.repaso_appi_pizza.R

// Esta clase recibirá la vista que vamos a pintar
class PizzaViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    private val binding = ItemPizzaBinding.bind(view)

    fun render(pizza: Pizza) {
        binding.tvNombrePizza.text = pizza.nombre
        binding.tvDescripcionPizza.text = pizza.descripcion
        binding.tvPrecioPizza.text = "${pizza.precio}€"
        binding.tvCategoriaPizza.text = pizza.categoria.uppercase()

        // Cargar imagen con Picasso
        Picasso.get()
            .load(pizza.imagen)
            .placeholder(R.mipmap.ic_launcher)
            .error(R.mipmap.ic_launcher)
            .into(binding.ivPizza)
    }
}