// TODO: Parte 4 - Ejercicio 1
import 'package:flutter/material.dart';
import 'package:examen2ev26/model/peliculas_response.dart';
import 'package:examen2ev26/services/peliculas_service.dart';

// StatefulWidget porque necesitamos iniciar la llamada a la API en initState
class PeliculasScreen extends StatefulWidget {
  const PeliculasScreen({super.key});

  @override
  State<PeliculasScreen> createState() => _PeliculasScreenState();
}

class _PeliculasScreenState extends State<PeliculasScreen> {
  // Instancia del servicio de películas
  final PeliculasService _service = PeliculasService();

  // Future que guarda la llamada a la API - late porque se inicializa en initState
  late Future<List<Pelicula>> _peliculas;

  @override
  void initState() {
    super.initState();
    // Lanzamos la petición a la API nada más cargar la pantalla
    _peliculas = _service.getPeliculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Rest')),
      // FutureBuilder gestiona los 3 estados: cargando, error y datos
      body: FutureBuilder<List<Pelicula>>(
        future: _peliculas,
        builder: (context, snapshot) {

          // Estado cargando: la petición aún no ha terminado
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Estado error: algo ha fallado en la petición
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Estado datos: la petición ha devuelto la lista de películas
          final peliculas = snapshot.data!;

          // ListView.builder crea los items bajo demanda (más eficiente)
          return ListView.builder(
            itemCount: peliculas.length, // Número total de películas
            itemBuilder: (context, index) {
              final pelicula = peliculas[index]; // Película actual
              return Card(
                margin: const EdgeInsets.all(8), // Separación entre cards
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen de portada a ancho completo
                    Image.network(
                      pelicula.imagen,
                      width: double.infinity, // Ocupa todo el ancho
                      height: 200,
                      fit: BoxFit.cover, // Recorta para llenar el espacio
                      // Icono de error si la imagen no carga
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 80),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título en negrita y tamaño grande
                          Text(pelicula.titulo,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          // Año de lanzamiento en gris
                          Text('${pelicula.fecha}',
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          // Descripción completa de la película
                          Text(pelicula.descripcion),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}