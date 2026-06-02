// TODO: Parte 4 - Ejercicio 2
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen2ev26/model/peliculas_response.dart';

// Servicio que obtiene la lista de películas desde la API REST
class PeliculasService {
  // Obtengo la lista de peliculas del API: https://devsapihub.com/api-movies
  static const String _url = 'https://devsapihub.com/api-movies';

  // Método que devuelve la lista de películas
  Future<List<Pelicula>> getPeliculas() async {
    // Hacemos la petición GET a la API
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      // Si la respuesta es correcta, decodificamos el JSON
      final List<dynamic> data = json.decode(response.body);
      // Convertimos cada elemento del JSON en un objeto Pelicula
      return data.map((json) => Pelicula.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las películas');
    }
  }
}
// FIN TODO: Parte 4 - Ejercicio 2