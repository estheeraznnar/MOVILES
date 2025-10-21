package org.iesch.app07.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import org.iesch.app07.R
private const val NAME_BUNDLE = "name_bundle"
private const val ADRESS_BUNDLE = "adress_bundle"
class PrimerFragment : Fragment() {
    private var param1: String? = null
    private var param2: String? = null

    //Este metodo se llama cuando la vista ha sido cargada
    //cuando llamamos a la instancia  llegamos a onCreate y aqui le preguntamos si hay algun argumento
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(NAME_BUNDLE)
            param2 = it.getString(ADRESS_BUNDLE)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_primer, container, false)
    }
    //los fragments se suelen instanciar a traves de un metodo publico llamado newInstance
    //Lo que pongamos aqui suele ser los parametros que quiero que reciba

    companion object {
        @JvmStatic
        fun newInstance(nombre: String, direccion: String) =
            PrimerFragment().apply {
                //cojo el atributo argumentos de este fragment y le paso un bundle
                arguments = Bundle().apply {
                    putString(NAME_BUNDLE, nombre)
                    putString(ADRESS_BUNDLE, direccion)
                }
            }
    }
}