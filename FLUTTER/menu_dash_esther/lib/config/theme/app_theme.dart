import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const listaColores = [
    Color.fromARGB(255, 91, 176, 219),
    Color.fromARGB(255, 182, 156, 255),
    Colors.greenAccent,
    Colors.teal,
    Color.fromARGB(255, 255, 110, 159),
    Color.fromARGB(255, 253, 235, 163),
    Color.fromARGB(255, 255, 136, 127),
    Colors.indigoAccent,
    Colors.deepOrangeAccent,
    Colors.cyanAccent
  ];

  //Texto para mi app ponerle estilo a todos los textos el mismo  
  ThemeData getTheme() => ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates(),
      titleMedium: GoogleFonts.montserratAlternates(fontSize: 30),
      titleSmall: GoogleFonts.montserratAlternates(fontSize: 25),
      bodyLarge: GoogleFonts.montserratAlternates(),
      bodyMedium: GoogleFonts.montserratAlternates(),
      bodySmall: GoogleFonts.montserratAlternates(),
    )
  );
}