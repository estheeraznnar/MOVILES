import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'marcador_provider.dart';

/// Vista "Resultado": muestra el marcador y quién va ganando.
/// Es un StatelessWidget; lee los puntos de MarcadorProvider.
class ResultadoView extends StatelessWidget {
  const ResultadoView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarcadorProvider>();
    final local = provider.puntosLocal;
    final visitante = provider.puntosVisitante;

    String mensaje;
    if (local > visitante) {
      mensaje = 'Gana el Local 🎉';
    } else if (visitante > local) {
      mensaje = 'Gana el Visitante 🎉';
    } else {
      mensaje = 'Fue un empate 😕';
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Local - Visitante', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 40),
          Text(
            '$local - $visitante',
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 24),
          Text(mensaje, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
