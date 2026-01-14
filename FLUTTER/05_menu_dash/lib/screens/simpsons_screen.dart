import 'package:flutter/material.dart';
import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:menu_dash/sevices/simpsons_service.dart';

class SimpsonsScreen extends StatefulWidget {
   
  const SimpsonsScreen({Key? key}) : super(key: key);

  @override
  State<SimpsonsScreen> createState() => _SimpsonsScreenState();
}

class _SimpsonsScreenState extends State<SimpsonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simpsons'),), 
      body: FutureBuilder(
        future: SimpsonsService().getpersonajesSimpsonwithHttp(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text('Error al cargar los personajes de la Api'),);
          }else{
            final personajes = snapshot.data?.results ?? [];
            return ListView.builder(
              itemCount: personajes.length,
              itemBuilder: (context, index){
                final personaje = personajes[index];
                return Card(
                  child: Column(
                    children: [
                      Image.network('https://cdn.thesimpsonsapi.com/200${personaje.portraitPath}'),
                      Text(personaje.name),
                      Text(personaje.occupation)
                    ],
                  ),
                );
              }
            );
          }
        }
      )
    );
  }
}