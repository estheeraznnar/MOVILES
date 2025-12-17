import 'dart:convert';

import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroResponse?> getSuperHeroInfo(String superHeroName) async{

    final response = await http.get(
      Uri.parse(
        'https://www.superheroapi.com/api.php/a6e811fbc4a38f18dc0e73c01ba7d491/search/$superHeroName'
      ),
    );

    if(response.statusCode == 200){

      var decodeJson = jsonDecode(response.body);
      //Aqui ya tenemos el formato perfecto perfecto para poder usar nuestro constructor
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(decodeJson);
      return superheroResponse;
    
    }else{
      //Podemos hacer un par de cosas
      //Primera lanzar un error controlado
      //throw Exception('Filed to load superhero info');
      //Segunda devuelvo un nulo (hay que poner un ? arriba)
      return null;
    }

  }
}