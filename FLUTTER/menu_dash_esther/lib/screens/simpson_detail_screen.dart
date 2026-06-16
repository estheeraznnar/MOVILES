import 'package:flutter/material.dart';
import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:menu_dash/widgets/blur_container.dart';
import 'package:menu_dash/widgets/fade_animation_widget.dart';

// Pantalla de detalle de un personaje Simpsons
// Muestra los datos del personaje recibido por navegación
//la abre SimpsonsScreen y usa BlurnContainer y FadeAnimationWidget
class SimpsonDetailScreen extends StatefulWidget {
  final Personaje personaje; // El personaje llega desde la pantalla anterior mediante navegación
  const SimpsonDetailScreen({super.key, required this.personaje}); //constructor que obliga a recibir un personaje para poder mostrar la pantalla

  @override
  State<SimpsonDetailScreen> createState() => _SimpsonDetailScreenState();
}

class _SimpsonDetailScreenState extends State<SimpsonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personaje.name), //uso el nombre del personake como titulo
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: const Color(0xFF6750a1),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 228, 129),
      body: SingleChildScrollView( // permito hacer scroll vertical si el contenido no cabe completo
        padding: const EdgeInsets.all(16),
        child: Column( // Muestro información básica del personaje: trabajo, edad y frases
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // imagen principal del personaje mostrada en grande
            Image.network(widget.personaje.imageUrl, height: 250),
            const SizedBox(height: 16),
            Positioned(
              bottom: 20,
              left: 12,
              child: FadeAnimationWidget(
                intervalEnd:
                    0.6, //de cuanto quiero que sea la transicion y cuanto quiero que tarde en mostrarse
                child: BlurContainer(
                  //esto me lleva a la clase blur container y lo que hace es como darle transparencia al bton
                  child: Container(
                    width: 230,
                    height: 70,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        184,
                        179,
                        162,
                      ).withValues(alpha: 0.25),
                      borderRadius: .circular(10),
                    ),
                    child: Text(
                      widget.personaje.name,
                      style: TextStyle(fontWeight: .bold, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimationWidget(
                intervalStart: 0.15,
                child: Text(
                  "Tabajo: ${widget.personaje.occupation}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 134, 134, 134),
                    fontSize: 18,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimationWidget(
                intervalStart: 0.4, //Le pogo que vaya apareciendo poco a poco
                child: Text(
                  "Edad: ${widget.personaje.age}",
                  style: TextStyle(color: const Color.fromARGB(179, 0, 0, 0), fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimationWidget(
                intervalStart: 0.4,
                child: Text(
                  'Frases de ${widget.personaje.name}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimationWidget(
                intervalStart: 0.6,
                //Lista de frases celebres asociadas al personaje
                child: ListView.builder(
                  itemCount: widget.personaje.phrases.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) { //construyo una fila por frase
                    final frase = widget.personaje.phrases[index]; //accedo a la frase actual usando su indice dentro de la lista
                    return SizedBox(
                      child: ListTile(
                        title: Text(frase),
                        titleTextStyle: TextStyle(fontSize: 15, color: Colors.black, fontStyle: .italic),
                      )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
