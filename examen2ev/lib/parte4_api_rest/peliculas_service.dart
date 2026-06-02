import 'dart:convert';

import 'package:http/http.dart' as http;

import 'peliculas_response.dart';

/// Servicio que obtiene la lista de películas desde la API REST.
/// Documentación: https://devsapihub.com/docs/api-movies
class PeliculasService {
  final String _baseUrl = 'devsapihub.com';
  final String _endpoint = '/api-movies';

  /// Realiza la petición GET y devuelve la lista de películas.
  Future<List<Pelicula>> getPeliculas() async {
    final url = Uri.https(_baseUrl, _endpoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Usamos bodyBytes + utf8 para que los acentos se muestren bien.
      return peliculasFromJson(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(
        'Error al obtener las películas (código ${response.statusCode})',
      );
    }
  }
}
