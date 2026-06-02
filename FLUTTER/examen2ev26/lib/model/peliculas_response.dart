// TODO: Parte 3 - Ejercicio 3
// Modelo que representa una película obtenida de la API
class Pelicula {
  final String titulo;
  final String descripcion;
  final String imagen;
  final int fecha;

  // Constructor con todos los campos obligatorios
  Pelicula({
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.fecha,
  });

  // Factory que convierte el JSON de la API en un objeto Pelicula
  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      titulo: json['title'] ?? '',
      descripcion: json['description'] ?? '', // era 'overview', ahora es 'description'
      imagen: json['image_url'] ?? '',        // era 'poster_path', ahora es 'image_url'
      fecha: json['year'] ?? 0,              // era 'release_date', ahora es 'year' (int)
    );
  }
}