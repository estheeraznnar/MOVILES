import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:menu_dash/config/preferences/preferencias.dart';
import 'package:menu_dash/config/theme/app_theme.dart';
import 'package:menu_dash/screens/apijson_screen.dart';
import 'package:menu_dash/screens/contador_screen.dart';
import 'package:menu_dash/screens/disenios_screens.dart';
import 'package:menu_dash/screens/lector_qr_screen.dart';
import 'package:menu_dash/screens/mapbox_screen.dart';
import 'package:menu_dash/screens/menu_screen.dart';
import 'package:menu_dash/screens/razas_api_screen.dart';
import 'package:menu_dash/screens/settings_screen.dart';
import 'package:menu_dash/screens/simpsons_screen.dart';
import 'package:menu_dash/providers/marcador_provider.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Preferencias.init();
  await dotenv.load(fileName: ".env");
  MapboxOptions.setAccessToken(dotenv.env['MAPBOX_ACCES_TOKEN']!); //le tengo que poner lo que tengo en el archivo .env
  
  runApp(
    // ChangeNotifierProvider envuelve toda la app para compartir el estado del marcador
    ChangeNotifierProvider(
      // create: crea una instancia del MarcadorProvider cuando se inicia la app
      // El _ indica que no usamos el contexto del BuildContext
      create: (_) => MarcadorProvider(),
      // child: es la aplicación principal que tendrá acceso al Provider
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //El tema que quiero usar es el que me devuelva apptheme
      theme: AppTheme().getTheme(),
      routes: {
        '/': (context) => MenuScreen(),
        'api1' : (context) => ApiJsonPlaceUsersScreen(), 
        'simpsons' : (context) => SimpsonsScreen(),
        'estilos' : (context) => DiseniosScreens(),
        'contadorbaloncesto': (context) => ContadorScreen(),
        'apiperros': (context) => RazasApiScreen(),
        'lectorQr': (context) => LectorQrScreen(),
        'settings': (context) => SettingsScreen(),
        'mapas': (context) => MapboxScreen(),
      },
    );
  }
}