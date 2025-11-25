import 'package:componentes_02/config/theme/app_theme.dart';
import 'package:componentes_02/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //para quitar el banner
      theme: AppTheme(colorSeleccionado: 2).obtenerTema(),
      home: HomeScreen()
    );
  }
}