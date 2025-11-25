import 'package:flutter/material.dart';

const listaColores = <Color>[
  Colors.blue,
  Colors.indigo,
  Colors.green,
  Colors.pink,
  Colors.purple,
  Colors.yellow
];

class AppTheme {

  final int colorSeleccionado;

  AppTheme({this.colorSeleccionado = 0}); //Si no hay ninguno seleccionado se pondra el 0 por

  ThemeData obtenerTema() => ThemeData(
    useMaterial3: false,
    colorSchemeSeed: listaColores[colorSeleccionado], //coge el color que se ha seleccionado y lo coloca en la app

    appBarTheme: AppBarTheme( //el theme del app bar
      centerTitle: true,
    )
  );

}