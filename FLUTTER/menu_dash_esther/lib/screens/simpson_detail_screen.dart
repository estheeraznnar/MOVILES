import 'package:flutter/material.dart';
import 'package:menu_dash/api/simpsons_personajes_respose.dart';
import 'package:menu_dash/widgets/blur_container.dart';
import 'package:menu_dash/widgets/fade_animation_widget.dart';

class SimpsonDetailScreen extends StatefulWidget {
  final Personaje personaje;
  const SimpsonDetailScreen({super.key, required this.personaje});

  @override
  State<SimpsonDetailScreen> createState() => _SimpsonDetailScreenState();
}

class _SimpsonDetailScreenState extends State<SimpsonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personaje.name),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: const Color(0xFF6750a1),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 228, 129),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                intervalStart: 0.4,
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
                child: ListView.builder(
                  itemCount: widget.personaje.phrases.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final frase = widget.personaje.phrases[index];
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
