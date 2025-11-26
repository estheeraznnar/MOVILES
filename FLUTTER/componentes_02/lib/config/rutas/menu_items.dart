import 'package:flutter/material.dart';

class MenuItems {

  final String titulo;
  final String subtitulo;
  final String link;
  final IconData icono;

  MenuItems({
    required this.titulo, 
    required this.subtitulo, 
    required this.link, 
    required this.icono
  });

}

final menuItems = <MenuItems>[

  MenuItems(
    titulo: 'botones', 
    subtitulo: 'Un simple ejemlo de botones', 
    link: '/botones', 
    icono: Icons.radio_button_checked,
  ), 
  MenuItems(
    titulo: 'listas', 
    subtitulo: 'Un simple ejemlo de Lista', 
    link: '/listas', 
    icono: Icons.list,
  ), 
  MenuItems(
    titulo: 'Tarjetas', 
    subtitulo: 'Un simple ejemlo de tarjetas', 
    link: '/tarjetas', 
    icono: Icons.credit_card,
  ),
  MenuItems(
    titulo: 'Alertas', 
    subtitulo: 'una alerta en flutter', 
    link: '/alertas', 
    icono: Icons.alarm_on_rounded,
  )

];