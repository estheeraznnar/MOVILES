import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../parte1_rutas/app_routes.dart';
import 'formulario_provider.dart';

/// Formulario (nombre, edad y deportes favoritos) que guarda lo introducido
/// en el FormularioProvider para poder mostrarlo luego en ResultadoScreen.
class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _edadCtrl;

  @override
  void initState() {
    super.initState();
    // Inicializamos los campos con lo que ya hubiera guardado el provider,
    // así al volver al formulario se conservan los datos.
    final provider = context.read<FormularioProvider>();
    _nombreCtrl = TextEditingController(text: provider.nombre);
    _edadCtrl = TextEditingController(text: provider.edad);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _edadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormularioProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Formulario')),
      // SingleChildScrollView evita el desbordamiento al abrir el teclado.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nombre
            TextField(
              controller: _nombreCtrl,
              onChanged: (valor) => provider.nombre = valor,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Edad
            TextField(
              controller: _edadCtrl,
              keyboardType: TextInputType.number,
              onChanged: (valor) => provider.edad = valor,
              decoration: const InputDecoration(
                labelText: 'Edad',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Deportes favoritos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // Checkboxes de deportes
            ...FormularioProvider.deportesDisponibles.map(
              (deporte) => CheckboxListTile(
                title: Text(deporte),
                value: provider.tieneDeporte(deporte),
                onChanged: (seleccionado) =>
                    provider.toggleDeporte(deporte, seleccionado ?? false),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.resultado),
              icon: const Icon(Icons.visibility),
              label: const Text('Ver resultado'),
            ),
          ],
        ),
      ),
    );
  }
}
