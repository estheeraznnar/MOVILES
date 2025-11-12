package org.iesch.a08_firebasedam

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.firebase.firestore.FirebaseFirestore
import org.iesch.a08_firebasedam.databinding.ActivityListaTareasBinding
import org.iesch.a08_firebasedam.modelo.Tareas
import org.iesch.a08_firebasedam.recycler.TareaAdaptador

class ListaTareasActivity : AppCompatActivity() {

    private lateinit var binding: ActivityListaTareasBinding
    //Creamos la instancia para la base de datos
    private val db = FirebaseFirestore.getInstance()
    //creamos una lista mutable para almacenar las tareas
    private val listaTareas = mutableListOf<Tareas>()
    //Creamos el adaptador
    private lateinit var tareaAdaptador: TareaAdaptador

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityListaTareasBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(binding.root) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        //configuramos nuestro Recyclerview
        configurarRecyclerView()
        //creamos las tareas desde Firebase Firestore
        cargarTareas()
        //Configuramos los botones
        initUI()

    }

    private fun initUI() {
        binding.btnAgregar.setOnClickListener {
            agregarTarea()
        }
    }

    private fun agregarTarea() {

        mostrarLoading(true)

        val titulo = binding.etTitulo.text.toString().trim()
        val descripcion = binding.etDescripcion.text.toString().trim()

        if (titulo.isEmpty() || descripcion.isEmpty()){
            Toast.makeText(this, "Debes rellear los campos", Toast.LENGTH_LONG).show()
        }else{
            //creamos una nueva tarea
            val nuevaTareaRef = db.collection("tareas").document()
            val nuevaTarea = Tareas(
                id = nuevaTareaRef.id,
                titulo = titulo,
                descripcion = descripcion,
                completada = false
            )

            nuevaTareaRef.set(nuevaTarea)
                .addOnCompleteListener {
                    Toast.makeText(this, "Tarea añadida correctamente", Toast.LENGTH_LONG).show()

                    //Limpiamos los campos de titulo y descripcion
                    binding.etTitulo.text.clear()
                    binding.etDescripcion.text.clear()

                    //recargamos la lista de tareas
                    cargarTareas()
                }
                .addOnFailureListener {
                    Toast.makeText(this, "Error al añadir la tarea", Toast.LENGTH_LONG).show()
                }
        }
    }

    private fun cargarTareas() {
        // mostramos el loading antes de llamar a mostrar tarea
        mostrarLoading(true)
        db.collection("tareas")
            .addSnapshotListener { snapshot, error ->
                if (error != null){
                    Toast.makeText(this, "Error al cargar las tareas", Toast.LENGTH_LONG).show()
                    return@addSnapshotListener
                }
                listaTareas.clear()
                snapshot?.documents?.forEach { document ->
                    val tarea = Tareas(
                        id = document.id,
                        titulo = document.getString("titulo") ?: "",
                        descripcion = document.getString("descripcion") ?: "",
                        completada = document.getBoolean("completada") ?: false
                    )
                    listaTareas.add(tarea)
                }

                tareaAdaptador.actuaLizarlista(listaTareas)

                mostrarLoading(false)
            }
        mostrarLoading(false)
            /*.get()
            .addOnCompleteListener { result ->
                listaTareas.clear()
                for (document in result.result){
                    val tarea = document.toObject(Tareas::class.java)
                    listaTareas.add(tarea)
                }
                //Notificamos al adaptador que los datos han cambiado
                tareaAdaptador.actuaLizarlista(listaTareas)
            }
            .addOnCompleteListener {
                Toast.makeText(this, "Error al cargar las tareas", Toast.LENGTH_LONG).show()
            }*/
    }

    private fun configurarRecyclerView() {
        tareaAdaptador = TareaAdaptador(
            listaTareas,
            onBorrar = {tarea ->
                //borramos de firebase
                borraTarea(tarea)
            },
            onToogleCompletada = {tareas ->
                actualizarTarea(tareas)
            }
        )
        //Asignamos el adaptador a nuestro RecyclerView
        binding.rvTareas.layoutManager = androidx.recyclerview.widget.LinearLayoutManager(this)
        binding.rvTareas.adapter = tareaAdaptador
    }

    private fun borraTarea( tarea: Tareas ){
        db.collection("tareas")
            .document( tarea.id )
            .delete()
            .addOnSuccessListener {
                Toast.makeText(this, "Tarea eliminada", Toast.LENGTH_LONG).show()
            }
    }

    private fun actualizarTarea(tareas: Tareas){
        mostrarLoading(true)
        db.collection("tareas")
            .document(tareas.id)
            .update("completada", tareas.completada)
            .addOnCompleteListener {
                Toast.makeText(this, "Tarea modificada correctamente", Toast.LENGTH_LONG).show()
            }
        mostrarLoading(false)
    }

    private fun mostrarLoading(mostrar: Boolean){
        binding.progressBar.visibility = if (mostrar){
            android.view.View.VISIBLE
        }else{
            android.view.View.GONE
        }
    }
}