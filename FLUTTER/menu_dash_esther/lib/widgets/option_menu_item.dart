import 'package:flutter/material.dart';

//Modelo que representa una opcion del menu principal
//Guarda el color, icono, texto y ruta de navegacion
class OptionMenuItem {

  final Color color;
  final IconData iconData;
  final String texto;
  final String screenName;

  OptionMenuItem({
    required this.color, 
    required this.iconData, 
    required this.texto, 
    required this.screenName
  });

}