import 'package:flutter/material.dart';

import 'hero_item.dart';

/// Pantalla de detalle de la demo Hero. Muestra el mismo icono que la lista
/// pero en grande; al compartir el mismo [Hero] tag, Flutter anima la
/// transición del icono de una pantalla a la otra.
class HeroDetalleScreen extends StatelessWidget {
  final HeroItem item;

  const HeroDetalleScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.titulo),
        backgroundColor: item.color,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Mismo tag que en la lista -> Hero anima el icono al entrar/salir.
            Hero(
              tag: item.tag,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: item.color,
                child: Icon(item.icono, size: 90, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              item.descripcion,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '¿Qué es Hero?\n\n'
                  'Hero crea una animación de "elemento compartido" entre dos '
                  'pantallas. Se envuelve un widget en Hero con un "tag" único '
                  'en ambas pantallas y, al navegar, Flutter anima ese widget '
                  'de su posición/tamaño en la primera a los de la segunda.\n\n'
                  'Usos típicos: miniatura de una foto que se amplía, logo o '
                  'avatar que se desplaza, tarjetas de producto que se abren.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
