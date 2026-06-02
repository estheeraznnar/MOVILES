import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'marcador_provider.dart';

/// Vista "Marcador": permite sumar/restar puntos al local y al visitante.
/// Es un StatelessWidget; el estado vive en MarcadorProvider.
class MarcadorView extends StatelessWidget {
  const MarcadorView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarcadorProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- LOCAL ---
        const Text(
          'Local',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        _FilaEquipo(
          puntos: provider.puntosLocal,
          onRestar: provider.restarLocal,
          onSumar1: () => provider.sumarLocal(1),
          onSumar2: () => provider.sumarLocal(2),
        ),

        // --- Controles centrales ---
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Reiniciar marcador
              IconButton.filledTonal(
                icon: const Icon(Icons.restore),
                tooltip: 'Reiniciar',
                onPressed: provider.reiniciar,
              ),
              const Icon(
                Icons.sports_basketball,
                color: Colors.orange,
                size: 70,
              ),
              // Ir a la pestaña de resultado
              IconButton.filledTonal(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Ver resultado',
                onPressed: () => provider.cambiarPagina(1),
              ),
            ],
          ),
        ),

        // --- VISITANTE ---
        _FilaEquipo(
          puntos: provider.puntosVisitante,
          onRestar: provider.restarVisitante,
          onSumar1: () => provider.sumarVisitante(1),
          onSumar2: () => provider.sumarVisitante(2),
        ),
        const Text(
          'Visitante',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Fila con los botones -1 / +1 / +2 y el marcador de un equipo.
class _FilaEquipo extends StatelessWidget {
  final int puntos;
  final VoidCallback onRestar;
  final VoidCallback onSumar1;
  final VoidCallback onSumar2;

  const _FilaEquipo({
    required this.puntos,
    required this.onRestar,
    required this.onSumar1,
    required this.onSumar2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: onRestar, child: const Text('-1')),
        Text(
          '$puntos',
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: onSumar1, child: const Text('+1')),
            ElevatedButton(onPressed: onSumar2, child: const Text('+2')),
          ],
        ),
      ],
    );
  }
}
