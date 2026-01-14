import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:http/http.dart' as http;

class SimpsonsService {

  Future<SimpsonsPersonajesResponse> getpersonajesSimpsonwithHttp() async {
    final response = await http.get(
      Uri.parse('https://thesimpsonsapi.com/api/characters')
    );

     if(response.statusCode == 200){
      return simpsonsPersonajesResponseFromJson(response.body);
    }else{
      //si la respuesta no es correcta lanzamos un error
      throw Exception("Error al cargar la lista de personajes simpsons");
    }
  }

}