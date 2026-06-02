import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';

/// Pantalla 4 de la práctica de navegación.
/// Desde aquí se puede navegar a las pantallas 3 y 5.
class Pantalla4 extends StatelessWidget {
  const Pantalla4({super.key});

  static const Color _color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 4'),
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
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav5),
              child: const Text('Ir a Pantalla 5'),
            ),
          ],
        ),
      ),
    );
  }
}
