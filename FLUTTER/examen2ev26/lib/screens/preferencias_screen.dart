import 'package:flutter/material.dart';
import 'package:examen2ev26/config/preferencias.dart'; // ajusta la ruta si es necesario
// TODO: Parte 7 - Ejercicio 1

class PreferenciasScreen extends StatefulWidget {
  const PreferenciasScreen({super.key});

  @override
  State<PreferenciasScreen> createState() => _PreferenciasScreenState();
}

class _PreferenciasScreenState extends State<PreferenciasScreen> {
  // Controladores de texto
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();

  // Deportes disponibles
  final List<String> _deportes = ['Fútbol', 'Baloncesto', 'Tenis'];

  // Lista local de deportes seleccionados (para los checkboxes)
  List<String> _deportesSeleccionados = [];

  @override
  void initState() {
    super.initState();
    // Al abrir la pantalla cargamos los valores guardados en SharedPreferences
    _nombreController.text = Preferencias.nombre;
    _edadController.text =
        Preferencias.edad == 0 ? '' : '${Preferencias.edad}';
    _deportesSeleccionados = List.from(Preferencias.deportesFavoritos);
  }

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget
    _nombreController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      // SingleChildScrollView evita desbordamiento con el teclado
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---- CAMPO NOMBRE ----
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              // Guardamos en SharedPreferences cada vez que cambia el texto
              onChanged: (value) => Preferencias.nombre = value,
            ),
            const SizedBox(height: 16),

            // ---- CAMPO EDAD ----
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              // Guardamos la edad como int en SharedPreferences
              onChanged: (value) =>
                  Preferencias.edad = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 16),

            // ---- CHECKBOXES DEPORTES ----
            const Text(
              'Deportes favoritos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Generamos un checkbox por cada deporte
            Column(
              children: _deportes.map((deporte) {
                return CheckboxListTile(
                  title: Text(deporte),
                  // Marcado si está en la lista local
                  value: _deportesSeleccionados.contains(deporte),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _deportesSeleccionados.add(deporte);
                      } else {
                        _deportesSeleccionados.remove(deporte);
                      }
                      // Guardamos la lista actualizada en SharedPreferences
                      Preferencias.deportesFavoritos = _deportesSeleccionados;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // ---- BOTÓN ENVIAR ----
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Los datos ya están en SharedPreferences automáticamente
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preferencias guardadas')),
                  );
                },
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}