import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';

/// Pantalla 5 de la práctica de navegación.
/// Desde aquí se puede navegar a las pantallas 1, 2 y 4, y además
/// limpiar toda la pila de navegación para volver a la pantalla inicial.
class Pantalla5 extends StatelessWidget {
  const Pantalla5({super.key});

  static const Color _color = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 5'),
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
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.nav4),
              child: const Text('Ir a Pantalla 4'),
            ),
            const SizedBox(height: 24),
            // Elimina todas las pantallas de la pila y vuelve a la Pantalla 1.
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: _color),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.nav1,
                (route) => route.isFirst,
              ),
              icon: const Icon(Icons.home),
              label: const Text('Limpiar pila y volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
