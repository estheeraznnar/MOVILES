import 'package:flutter/material.dart';

import 'preferencias.dart';

/// Clon del formulario cuyos valores (nombre, edad y deportes) se guardan en
/// shared_preferences, de modo que persisten al cerrar y reabrir la app.
class PreferenciasScreen extends StatefulWidget {
  const PreferenciasScreen({super.key});

  @override
  State<PreferenciasScreen> createState() => _PreferenciasScreenState();
}

class _PreferenciasScreenState extends State<PreferenciasScreen> {
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _edadCtrl;
  late List<String> _deportes;

  static const List<String> deportesDisponibles = [
    'Fútbol',
    'Baloncesto',
    'Tenis',
  ];

  @override
  void initState() {
    super.initState();
    // Cargamos los valores ya guardados en shared_preferences.
    _nombreCtrl = TextEditingController(text: Preferencias.nombre);
    _edadCtrl = TextEditingController(text: Preferencias.edad);
    _deportes = List<String>.from(Preferencias.deportes);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _edadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nombre
            TextField(
              controller: _nombreCtrl,
              onChanged: (valor) => Preferencias.nombre = valor,
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
              onChanged: (valor) => Preferencias.edad = valor,
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
            ...deportesDisponibles.map(
              (deporte) => CheckboxListTile(
                title: Text(deporte),
                value: _deportes.contains(deporte),
                onChanged: (seleccionado) {
                  setState(() {
                    if (seleccionado ?? false) {
                      _deportes.add(deporte);
                    } else {
                      _deportes.remove(deporte);
                    }
                  });
                  // Guardamos la nueva lista en shared_preferences.
                  Preferencias.deportes = _deportes;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
