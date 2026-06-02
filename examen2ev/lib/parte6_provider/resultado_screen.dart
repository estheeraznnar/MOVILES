import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'formulario_provider.dart';

/// Pantalla que muestra los datos guardados en el FormularioProvider
/// (nombre, edad y deportes), cada uno en una línea centrada arriba.
class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Leemos los datos guardados en el provider.
    final provider = context.watch<FormularioProvider>();

    final deportes = provider.deportes.isEmpty
        ? 'Ninguno'
        : provider.deportes.join(', ');

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nombre: ${provider.nombre}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Edad: ${provider.edad}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Deportes favoritos: $deportes',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
