import 'package:flutter/material.dart';

import 'simpson_detalle_screen.dart';
import 'simpson_personaje.dart';
import 'simpson_service.dart';

/// Pantalla principal de la Práctica 12: muestra en una rejilla los 20
/// primeros personajes de la API de los Simpson. Al pulsar uno se navega
/// a su vista de detalle.
class SimpsonGridScreen extends StatelessWidget {
  const SimpsonGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final simpsonService = SimpsonService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 12 · Simpson'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<SimpsonPersonaje>>(
        future: simpsonService.getPersonajes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final personajes = snapshot.data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: personajes.length,
            itemBuilder: (_, i) => _PersonajeCard(personaje: personajes[i]),
          );
        },
      ),
    );
  }
}

/// Tarjeta amarilla con la imagen y el nombre del personaje.
class _PersonajeCard extends StatelessWidget {
  final SimpsonPersonaje personaje;

  const _PersonajeCard({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SimpsonDetalleScreen(personaje: personaje),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                personaje.imagenUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                personaje.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
