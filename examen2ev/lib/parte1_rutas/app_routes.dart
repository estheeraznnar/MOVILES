import 'package:flutter/material.dart';

import '../screens.dart';

/// Define el sistema de rutas con nombre de la aplicación: los nombres de
/// cada ruta, la ruta inicial y el mapa que asocia cada nombre con su pantalla.
class AppRoutes {
  // Nombres de las rutas
  static const String checking = 'checking';
  static const String login = 'login';
  static const String menu = 'menu';
  static const String peliculas = 'peliculas';
  static const String formulario = 'formulario';
  static const String resultado = 'resultado';
  static const String preferencias = 'preferencias';
  static const String empleados = 'empleados';
  // Práctica 07 - navegación (5 pantallas)
  static const String nav1 = 'nav1';
  static const String nav2 = 'nav2';
  static const String nav3 = 'nav3';
  static const String nav4 = 'nav4';
  static const String nav5 = 'nav5';
  // Práctica 08 - widget Hero
  static const String practica8 = 'practica8';
  // Práctica 09 - marcador de baloncesto (Provider + BottomNavigation)
  static const String practica9 = 'practica9';
  // Práctica 12 - API de los Simpson (vista y detalle)
  static const String practica12 = 'practica12';
  // Práctica 13 - lista de la compra (Firestore CRUD)
  static const String practica13 = 'practica13';

  // Ruta inicial: comprueba si el usuario está logueado.
  static const String initialRoute = checking;

  // Mapa de rutas con nombre
  static Map<String, WidgetBuilder> get routes => {
    checking: (_) => const SeleccionarPantalla(),
    login: (_) => const LoginScreen(),
    menu: (_) => const MenuScreen(),
    peliculas: (_) => const PeliculasScreen(),
    formulario: (_) => const FormularioScreen(),
    resultado: (_) => const ResultadoScreen(),
    preferencias: (_) => const PreferenciasScreen(),
    empleados: (_) => const EmpleadosScreen(),
    nav1: (_) => const Pantalla1(),
    nav2: (_) => const Pantalla2(),
    nav3: (_) => const Pantalla3(),
    nav4: (_) => const Pantalla4(),
    nav5: (_) => const Pantalla5(),
    practica8: (_) => const HeroListaScreen(),
    practica9: (_) => const BasketScreen(),
    practica12: (_) => const SimpsonGridScreen(),
    practica13: (_) => const ListaCompraScreen(),
  };
}
