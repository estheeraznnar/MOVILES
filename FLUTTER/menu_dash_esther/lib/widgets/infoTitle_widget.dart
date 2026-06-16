import 'package:flutter/material.dart';

//Es un pequeño widget reutilizable de texto doble: título y subtítulo.
//Es un pequeño widget reutilizable de texto doble: título y subtítulo.
class InfoTitleWidget extends StatelessWidget {
  const InfoTitleWidget({super.key, required this.titulo, required this.subTitulo});

  final String titulo;
  final String subTitulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(titulo, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: .bold),),
        SizedBox(height: 5,),
        Text(subTitulo, style: TextStyle(color: Colors.white70, fontSize: 12),)
      ],
    );
  }
}