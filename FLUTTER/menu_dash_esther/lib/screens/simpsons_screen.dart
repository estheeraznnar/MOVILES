import 'package:flutter/material.dart';
import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:menu_dash/screens/simpson_detail_screen.dart';
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
      appBar: AppBar(
        title: Text('The Simpsons'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: const Color(0xFF6750a1),
      ), 
      backgroundColor: const Color.fromARGB(255, 255, 228, 129),
      body: FutureBuilder(
        future: SimpsonsService().getpersonajesSimpsonwithHttp(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Text('Error al cargar los personajes de la Api'),);
          }else{
            final personajes = snapshot.data?.results ?? [];

            return Padding(
              padding: EdgeInsets.all(0.8),
              child: GridView.builder(
                itemCount: personajes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2
                ),
                itemBuilder: (context, index) {
                  final personaje = personajes[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8)
                            ),
                            child: Image.network(
                              personaje.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SimpsonDetailScreen(
                                      personaje: personaje,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                personaje.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        }
      )
    );
  }
}