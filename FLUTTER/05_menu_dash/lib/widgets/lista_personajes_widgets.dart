import 'package:flutter/material.dart';
class ListaPersonajesWidgets extends StatefulWidget {
  const ListaPersonajesWidgets({super.key});

  @override
  State<ListaPersonajesWidgets> createState() => _ListaPersonajesWidgetsState();
}

class _ListaPersonajesWidgetsState extends State<ListaPersonajesWidgets> {

  final tituloStyleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Text('Personajes', style: tituloStyleText,),
          Row(
            children: [
              _personajeLista('p1', 'Titulo', 'Subtitulo'),
              _personajeLista('p2', 'Titulo', 'Subtitulo'),
              _personajeLista('p3', 'Titulo', 'Subtitulo'),
            ],
          )
        ],
      ),
    );
  }

  Column _personajeLista(String imagen, String titulo, String subtitulo) {
    double anchoPantalla = MediaQuery.of(context).size.width -50;
    return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20), //redondea las esquinas
                  child: Image.asset(
                    "assets/$imagen.jpg",
                    width: anchoPantalla * 0.35,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
  }
}