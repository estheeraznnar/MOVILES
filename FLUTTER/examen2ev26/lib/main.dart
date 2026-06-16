import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:examen2ev26/screens/home_screen.dart';
import 'package:examen2ev26/screens/login_screen.dart';
import 'package:examen2ev26/screens/peliculas_screen.dart';
import 'package:examen2ev26/screens/formulario_screen.dart';
import 'package:examen2ev26/screens/resultados_screen.dart';
import 'package:examen2ev26/screens/preferencias_screen.dart';
import 'package:examen2ev26/screens/empleados_screen.dart';
import 'package:examen2ev26/screens/seleccionar_pantalla.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'provider/formulario_provider.dart';
import 'package:examen2ev26/config/preferencias.dart';

/*para que funcione actualizar el fluttter con flutter upgrade --force
luego rellenar con lo minimo los archivos
para que funcione limitar el grade
- notepad C:\Users\Esther\.gradle\gradle.properties
- dento: org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
         org.gradle.daemon=false
- flutter run*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Preferencias.init();
  runApp(
    // ChangeNotifierProvider envuelve toda la app
    // Así TODAS las pantallas pueden acceder al FormularioProvider
    ChangeNotifierProvider(
      create: (_) => FormularioProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen DAM 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/login':        (context) => const LoginScreen(),
        '/home':         (context) => const HomeScreen(),
        '/peliculas':    (context) => const PeliculasScreen(),
        '/formulario':   (context) => const FormularioScreen(),
        '/resultados':    (context) => const ResultadosScreen(),
        '/preferencias': (context) => const PreferenciasScreen(),
        '/empleados':    (context) => const EmpleadosScreen(),
        '/seleccionar':  (context) => const SeleccionarPantalla(),
      },
    );
  }
}
