import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';

/// Pantalla 3 de la práctica de navegación.
/// Desde aquí se puede navegar a las pantallas 1 y 2.
class Pantalla3 extends StatelessWidget {
  const Pantalla3({super.key});

  static const Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 3'),
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
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav1),
              child: const Text('Ir a Pantalla 1'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav2),
              child: const Text('Ir a Pantalla 2'),
            ),
          ],
        ),
      ),
    );
  }
}
