
import 'package:superhero_app/data/model/superhero_response_detail.dart';

class SuperheroResponse {

  final String reponse;
  final List<SuperheroResponseDetail> listasupperHeroe;

  SuperheroResponse({required this.reponse, required this.listasupperHeroe});

  //Necesito devolver un objeto SuperheroResponse con los campos que me interesan
  factory SuperheroResponse.fromJson(Map<String, dynamic> json){
    var lista = json['results'] as List;
    
    //El .map es como un for que recorre la lista y la aplica a la funcion que usamos
    List<SuperheroResponseDetail> listasupperHeroe = lista
      .map((heroe) => SuperheroResponseDetail.fromJson( heroe))
      .toList();
    final response = json['response'];
    return SuperheroResponse(
      reponse: response, 
      listasupperHeroe: listasupperHeroe
      );
  }

}