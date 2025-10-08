package org.iesch.app04.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import android.R
import android.widget.TextView
import android.widget.Toast

/*Paso 3 - Creamos el adaptador:
El adaptador es el puente entre nuestros datos y el RecyclerView.
Se encarga de:
1- Crear las visitas para cada elemento - onCreateViewHolder
2- Enlazar los datos con las vistas - onBindViewHolder
3- Indicar cuantos elementos hay - getItemCount
*/

class VersionesAndroidAdapter(val listaVersiones: List<String>) : RecyclerView.Adapter<AndroidVersionViewFolder>(){
    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): AndroidVersionViewFolder {
        //Paso 5 - Crea una nueva vista cuando es necesario
        //Infla el valor para cada Item
        val layoutInflater = LayoutInflater.from(parent.context)
        return AndroidVersionViewFolder(layoutInflater.inflate(R.layout.simple_list_item_1, parent, false))
    }

    override fun onBindViewHolder(
        holder: AndroidVersionViewFolder,
        position: Int
    ) {
        //Paso 6 - este es el metodo que pinta los atributos
        val nombreVersion = listaVersiones[position]
        holder.render(nombreVersion)
    }

    //Paso 4 - Este metodo devuelve el numero total de elementos
    override fun getItemCount(): Int {
        return listaVersiones.size
    }


}

class AndroidVersionViewFolder(view: View) : RecyclerView.ViewHolder(view){

    //Paso 7 - aqui iria el codigo para pintar los atributos
    //Metodo de conceniencia para usar los datos
    fun render(version: String){
        itemView.findViewById<TextView>(R.id.text1).text = version

        //Paso 10 - Añadir el listenner para tomar el control
        itemView.setOnClickListener {
            Toast.makeText(itemView.context, version, Toast.LENGTH_LONG).show()
        }
    }

}