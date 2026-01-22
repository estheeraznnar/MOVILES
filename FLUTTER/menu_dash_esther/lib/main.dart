import 'package:flutter/material.dart';
import 'package:menu_dash/screens/apijson_screen.dart';
import 'package:menu_dash/screens/contador_screen.dart';
import 'package:menu_dash/screens/disenios_screens.dart';
import 'package:menu_dash/screens/lector_qr_screen.dart';
import 'package:menu_dash/screens/menu_screen.dart';
import 'package:menu_dash/screens/razas_api_screen.dart';
import 'package:menu_dash/screens/simpsons_screen.dart';
import 'package:menu_dash/providers/marcador_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  // ChangeNotifierProvider envuelve toda la app para compartir el estado del marcador
  ChangeNotifierProvider(
    // create: crea una instancia del MarcadorProvider cuando se inicia la app
    // El _ indica que no usamos el contexto del BuildContext
    create: (_) => MarcadorProvider(),
    // child: es la aplicación principal que tendrá acceso al Provider
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MenuScreen(),
        'api1' : (context) => ApiJsonPlaceUsersScreen(), 
        'simpsons' : (context) => SimpsonsScreen(),
        'estilos' : (context) => DiseniosScreens(),
        'contadorbaloncesto': (context) => ContadorScreen(),
        'apiperros': (context) => RazasApiScreen(),
        'lectorQr': (context) => LectorQrScreen(),
      },
    );
  }
}