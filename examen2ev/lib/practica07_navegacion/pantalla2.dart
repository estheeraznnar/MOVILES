import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';

/// Pantalla 2 de la práctica de navegación.
/// Desde aquí se puede navegar a la pantalla 5.
class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  static const Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 2'),
        backgroundColor: _color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _color,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.nav5),
          child: const Text('Ir a Pantalla 5'),
        ),
      ),
    );
  }
}
