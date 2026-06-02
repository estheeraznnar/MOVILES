import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen2ev26/provider/formulario_provider.dart';

class ResultadosScreen extends StatelessWidget {
  const ResultadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados Provider')),
      // Consumer escucha el provider y reconstruye el widget cuando cambian los datos
      // Así los resultados siempre están actualizados con lo que hay en el provider
      body: Consumer<FormularioProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Mostramos el nombre guardado en el provider
                Text('Nombre: ${provider.nombre}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),

                // Mostramos la edad guardada en el provider
                Text('Edad: ${provider.edad} años',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),

                // Título de la sección deportes
                const Text('Deportes favoritos:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),

                // Iteramos la lista de deportes seleccionados y mostramos cada uno
                // El operador ... (spread) expande la lista de widgets dentro del Column
                ...provider.deportesFavoritos.map(
                  (d) => Text('- $d', style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}