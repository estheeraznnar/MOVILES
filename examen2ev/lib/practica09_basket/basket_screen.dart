import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'marcador_provider.dart';
import 'marcador_view.dart';
import 'resultado_view.dart';

/// Pantalla principal de la Práctica 9. Contiene el BottomNavigationBar con
/// dos pestañas (Marcador y Resultado) y muestra la vista correspondiente
/// según la pestaña activa guardada en el provider.
class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarcadorProvider>();

    const vistas = [MarcadorView(), ResultadoView()];

    return Scaffold(
      appBar: AppBar(title: const Text('Basketball Score')),
      body: vistas[provider.paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.paginaActual,
        onTap: provider.cambiarPagina,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Marcador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard),
            label: 'Resultado',
          ),
        ],
      ),
    );
  }
}
