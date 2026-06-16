import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:http/http.dart' as http;

// Servicio que descarga personajes de The Simpsons API
// Devuelve la respuesta ya parseada a modelo Dart
class SimpsonsService {

  Future<SimpsonsPersonajesResponse> getpersonajesSimpsonwithHttp() async { // Este método hace una petición HTTP y devuelve la respuesta convertida a modelo Dart
    final response = await http.get( // Llamamo al endpoint de personajes de la API
      Uri.parse('https://thesimpsonsapi.com/api/characters')
    );

     if(response.statusCode == 200){  // Si la API responde correctamente, transformamos el JSON a objetos Dart
      return simpsonsPersonajesResponseFromJson(response.body);
    }else{
      //si la respuesta no es correcta lanzamos un error
      throw Exception("Error al cargar la lista de personajes simpsons"); 
    }
  }

}