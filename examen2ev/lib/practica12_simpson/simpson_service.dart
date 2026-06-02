import 'dart:convert';

import 'package:http/http.dart' as http;

import 'simpson_personaje.dart';

/// Servicio que obtiene los personajes de la API de los Simpson.
/// API: https://thesimpsonsapi.com/api/characters
class SimpsonService {
  final String _baseUrl = 'thesimpsonsapi.com';
  final String _endpoint = '/api/characters';

  /// Devuelve los 20 primeros personajes.
  Future<List<SimpsonPersonaje>> getPersonajes() async {
    final url = Uri.https(_baseUrl, _endpoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final personajes = personajesFromJson(utf8.decode(response.bodyBytes));
      return personajes.take(20).toList();
    } else {
      throw Exception(
        'Error al obtener los personajes (código ${response.statusCode})',
      );
    }
  }
}
