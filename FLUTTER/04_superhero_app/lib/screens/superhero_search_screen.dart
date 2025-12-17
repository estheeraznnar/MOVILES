import 'dart:math';

import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository/repository.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {

//Objeto los interrogantes es para qe las dos cosas pueden ser nulas
  Future<SuperheroResponse?>? _superHeroInfo;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SuperHero Search'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Busca un superheroe',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder()
              ),
              onChanged: (nombreHeroe) {
                setState(() {
                  _superHeroInfo = repository.getSuperHeroInfo(nombreHeroe);
                });
              },
            ),
            FutureBuilder(
              future: _superHeroInfo, 
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else if (snapshot.hasError){
                  return Text('Error al realizar la busqueda');
                }else if(!snapshot.hasData){
                  return Text('No existen resultados');
                } else {
                  // Ahora aqui tenemos un listado de Superheroes
                  var listaSuperHeroes = snapshot.data?.listasupperHeroe;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: listaSuperHeroes?.length ?? 0,
                      itemBuilder: (context, index) {
                        //return Text(listaSuperHeroes![index].name);
                        return Image.network(listaSuperHeroes![index]);
                        /*return Column(
                          children: [
                            ListTile(
                              title: Text(listaSuperHeroes![index].name),
                              subtitle: Text('Subtitulo'),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                
                              },
                            ),
                            Divider(),
                          ],
                        );*/
                      },
                      ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

