import 'package:flutter/material.dart';

import 'peliculas_response.dart';
import 'peliculas_service.dart';

/// Pantalla que pide la lista de películas a la API REST y la muestra en
/// tarjetas (póster, título, género, año, valoración y descripción).
class PeliculasScreen extends StatelessWidget {
  const PeliculasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final peliculasService = PeliculasService();

    return Scaffold(
      appBar: AppBar(title: const Text('Películas')),
      body: FutureBuilder<List<Pelicula>>(
        future: peliculasService.getPeliculas(),
        builder: (context, snapshot) {
          // Mientras carga, mostramos el indicador.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Si hay error, lo mostramos.
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final peliculas = snapshot.data ?? [];
          if (peliculas.isEmpty) {
            return const Center(child: Text('No hay películas.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: peliculas.length,
            itemBuilder: (_, i) => _PeliculaCard(pelicula: peliculas[i]),
          );
        },
      ),
    );
  }
}

/// Tarjeta que muestra una película: póster a ancho completo arriba y
/// la información (título, año, género, valoración y descripción) debajo.
class _PeliculaCard extends StatelessWidget {
  final Pelicula pelicula;

  const _PeliculaCard({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Póster a ancho completo
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              pelicula.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.movie, size: 60),
              ),
            ),
          ),
          // Datos de la película debajo
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pelicula.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${pelicula.genre} · ${pelicula.year}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(pelicula.stars.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  pelicula.description,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
