import 'package:flutter/material.dart';
import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:menu_dash/screens/simpson_detail_screen.dart';
import 'package:menu_dash/sevices/simpsons_service.dart';

// Pantalla que muestra personajes de Simpsons en formato grid
// Al pulsar un personaje abre la pantalla de detalle
//usa simpsonsservice y navega a SimpsonDetailScreen pasande el personaje
class SimpsonsScreen extends StatefulWidget {
   
  const SimpsonsScreen({Key? key}) : super(key: key);

  @override
  State<SimpsonsScreen> createState() => _SimpsonsScreenState();
}

class _SimpsonsScreenState extends State<SimpsonsScreen> {
  @override
  Widget build(BuildContext context) {
    // Estructura base de la pantalla: barra superior y contenido principal
    return Scaffold(
      appBar: AppBar(
        title: Text('The Simpsons'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: const Color(0xFF6750a1),
      ), 
      backgroundColor: const Color.fromARGB(255, 255, 228, 129),
      // FutureBuilder escucha el estado de la petición a la API
      body: FutureBuilder(
        future: SimpsonsService().getpersonajesSimpsonwithHttp(), 
        builder: (context, snapshot){ // El builder se ejecuta varias veces según cambia el estado del Future
          if(snapshot.connectionState == ConnectionState.waiting){ // Mientras la petición sigue en curso muestro un indicador de carga
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){ // Si algo falla en el servicio o en la petición, muestro un mensaje de error
            return Center(child: Text('Error al cargar los personajes de la Api'),);
          }else{
            // Extraigo la lista de personajes desde la respuesta de la API
            // Si por algún motivo no hay datos, uso una lista vacía para evitar errores
            final personajes = snapshot.data?.results ?? [];

            return Padding(
              padding: EdgeInsets.all(0.8),
              child: GridView.builder( //muestro el personaje en un cuadrado
                itemCount: personajes.length, //indico cuantas tarjetas debe contruir el grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2
                ),
                itemBuilder: (context, index) { //creo cada tarjeta a partir del personaje actual
                  final personaje = personajes[index];
                  //Card de cada personaje independiente a los demas
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
                            child: Image.network( //cargo la imagen remota del personaje usando su URL, viene directamente de la API no de assets locales
                              personaje.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            width: double.infinity,
                            //muestro el nombre del personaje y permito abrir su detalle
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                //navego a la pantalla de detalle y envio el personaje seleccionado.
                                //en vez de volver a pedir los datos, paso el objeto completo a la siguiente pantalla
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