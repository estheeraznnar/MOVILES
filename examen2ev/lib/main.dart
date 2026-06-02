import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'parte1_rutas/app_routes.dart';
import 'parte6_provider/formulario_provider.dart';
import 'parte7_preferencias/preferencias.dart';
import 'practica09_basket/marcador_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializamos shared_preferences antes de usar la app.
  await Preferencias.init();
  runApp(
    // Registramos el provider por encima de toda la app para que los datos
    // del formulario se mantengan disponibles en cualquier pantalla.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormularioProvider()),
        ChangeNotifierProvider(create: (_) => MarcadorProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

/// Widget raíz de la aplicación. Configura el MaterialApp: las rutas con
/// nombre, la ruta inicial y el tema con la fuente MontserratAlternates.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen 2ª Evaluación',
      // Sistema de rutas con nombre
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      // Fuente MontserratAlternates de Google Fonts en toda la aplicación
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
      ),
    );
  }
}
