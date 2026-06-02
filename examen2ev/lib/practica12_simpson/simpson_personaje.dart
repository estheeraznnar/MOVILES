import 'dart:convert';

/// La API devuelve un objeto con paginación; los personajes están en la
/// clave "results". Esta función extrae esa lista y la convierte en objetos.
List<SimpsonPersonaje> personajesFromJson(String str) {
  final Map<String, dynamic> decoded = json.decode(str);
  final List<dynamic> results = decoded['results'] ?? [];
  return results.map((x) => SimpsonPersonaje.fromJson(x)).toList();
}

/// Modelo de un personaje de la API de los Simpson (thesimpsonsapi.com).
class SimpsonPersonaje {
  final int id;
  final int? age;
  final String? birthdate;
  final String gender;
  final String name;
  final String occupation;
  final String portraitPath;
  final List<String> phrases;
  final String status;

  SimpsonPersonaje({
    required this.id,
    required this.age,
    required this.birthdate,
    required this.gender,
    required this.name,
    required this.occupation,
    required this.portraitPath,
    required this.phrases,
    required this.status,
  });

  /// URL completa de la imagen (el campo portrait_path es relativo).
  String get imagenUrl => 'https://cdn.thesimpsonsapi.com/500$portraitPath';

  factory SimpsonPersonaje.fromJson(Map<String, dynamic> json) =>
      SimpsonPersonaje(
        id: json['id'],
        age: json['age'],
        birthdate: json['birthdate'],
        gender: json['gender'] ?? '',
        name: json['name'] ?? '',
        occupation: json['occupation'] ?? '',
        portraitPath: json['portrait_path'] ?? '',
        phrases: List<String>.from(json['phrases'] ?? []),
        status: json['status'] ?? '',
      );
}
