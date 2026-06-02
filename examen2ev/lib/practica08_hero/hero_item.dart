import 'package:flutter/material.dart';

/// Modelo de cada elemento de la demo del widget Hero.
/// El campo [tag] es la etiqueta única que comparten la lista y el detalle:
/// Hero usa esa etiqueta para saber qué widget animar entre pantallas.
class HeroItem {
  final String tag;
  final IconData icono;
  final Color color;
  final String titulo;
  final String descripcion;

  const HeroItem({
    required this.tag,
    required this.icono,
    required this.color,
    required this.titulo,
    required this.descripcion,
  });
}

/// Datos de ejemplo para la demostración.
const List<HeroItem> heroItems = [
  HeroItem(
    tag: 'hero-musica',
    icono: Icons.music_note,
    color: Colors.purple,
    titulo: 'Música',
    descripcion: 'El icono de música ha volado desde la lista hasta aquí '
        'con una animación Hero.',
  ),
  HeroItem(
    tag: 'hero-foto',
    icono: Icons.photo_camera,
    color: Colors.teal,
    titulo: 'Fotografía',
    descripcion: 'Fíjate cómo el icono crece y se desplaza de forma fluida '
        'al abrir el detalle.',
  ),
  HeroItem(
    tag: 'hero-deporte',
    icono: Icons.sports_soccer,
    color: Colors.orange,
    titulo: 'Deporte',
    descripcion: 'La misma etiqueta (tag) en las dos pantallas es lo que '
        'permite la transición animada.',
  ),
  HeroItem(
    tag: 'hero-viaje',
    icono: Icons.flight,
    color: Colors.blue,
    titulo: 'Viajes',
    descripcion: 'Al volver atrás, el icono regresa animado a su sitio en '
        'la lista.',
  ),
];
