import 'dart:convert';

/// Convierte el JSON (un array de películas) en una lista de objetos Pelicula.
List<Pelicula> peliculasFromJson(String str) =>
    List<Pelicula>.from(json.decode(str).map((x) => Pelicula.fromJson(x)));

/// Convierte una lista de Pelicula de vuelta a JSON.
String peliculasToJson(List<Pelicula> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Modelo de una película tal y como la devuelve la API.
class Pelicula {
  final int id;
  final String title;
  final String description;
  final int year;
  final String imageUrl;
  final String genre;
  final double stars;

  Pelicula({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.imageUrl,
    required this.genre,
    required this.stars,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    year: json['year'],
    imageUrl: json['image_url'],
    genre: json['genre'],
    // stars puede venir como entero (5) o decimal (3.4): lo normalizamos.
    stars: (json['stars'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'year': year,
    'image_url': imageUrl,
    'genre': genre,
    'stars': stars,
  };
}
