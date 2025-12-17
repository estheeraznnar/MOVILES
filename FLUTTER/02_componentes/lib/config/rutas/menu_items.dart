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
  ),
  MenuItems(
    titulo: 'Sliders & Checks', 
    subtitulo: 'unejemplo simple de sliders y checks', 
    link: '/sliders', 
    icono: Icons.check_box,
  ),
  MenuItems(
    titulo: 'Navegation Bar', 
    subtitulo: 'unejemplo simple de un navegation bar', 
    link: '/navegationbar', 
    icono: Icons.amp_stories_rounded,
  ),
  MenuItems(
    titulo: 'Animaciones', 
    subtitulo: 'Un simple ejemplo de animaciones en Flutter', 
    link: '/animaciones', 
    icono: Icons.animation,
  ),
  MenuItems(
    titulo: 'Progress Indicator & SnackBar', 
    subtitulo: 'Un simple ejemplo de Indicators y SnackBar', 
    link: '/snackbar', 
    icono: Icons.refresh_rounded,
  ),
  MenuItems(
    titulo: 'Formularios', 
    subtitulo: 'Un simple ejemplo de Formularios', 
    link: '/formularios', 
    icono: Icons.info_outline,
  ),

];