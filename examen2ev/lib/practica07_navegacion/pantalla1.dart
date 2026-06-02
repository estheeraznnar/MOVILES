import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';

/// Pantalla 1 de la práctica de navegación (pantalla inicial).
/// Desde aquí se puede navegar a las pantallas 3 y 4.
class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  static const Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 1'),
        backgroundColor: _color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav3),
              child: const Text('Ir a Pantalla 3'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav4),
              child: const Text('Ir a Pantalla 4'),
            ),
          ],
        ),
      ),
    );
  }
}
