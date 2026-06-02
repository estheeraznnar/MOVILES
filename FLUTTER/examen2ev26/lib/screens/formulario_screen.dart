import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:examen2ev26/provider/formulario_provider.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  // TODO: Parte 6 - Ejercicio 1

  // Controladores para los campos de texto
  // Permiten leer y controlar el contenido de cada TextField
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();

  // Lista fija de deportes que se mostrarán como checkboxes
  final List<String> _deportes = ['Fútbol', 'Baloncesto', 'Tenis'];

  @override
  void dispose() {
    // IMPORTANTE: liberar los controladores cuando se destruye el widget
    // Si no se hace, hay fugas de memoria
    _nombreController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // listen: false → solo queremos escribir en el provider, no escuchar cambios
    // Si pusiéramos listen: true, el widget entero se reconstruiría en cada cambio
    final provider = Provider.of<FormularioProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Formulario')),
      // SingleChildScrollView evita el error de desbordamiento (overflow)
      // cuando aparece el teclado virtual y no cabe todo en pantalla
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
              // onChanged se ejecuta cada vez que el usuario escribe una letra
              // Guardamos el valor en el provider para que persista
              onChanged: (value) => provider.setNombre(value),
            ),
            const SizedBox(height: 16),

            // ---- CAMPO EDAD ----
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              // keyboardType numérico → muestra teclado de números en móvil
              keyboardType: TextInputType.number,
              // int.tryParse convierte el String a int de forma segura
              // Si el texto no es un número válido, devuelve null → usamos 0
              onChanged: (value) => provider.setEdad(int.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),

            // ---- SECCIÓN CHECKBOXES ----
            const Text(
              'Deportes favoritos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Consumer escucha cambios del provider y reconstruye solo esta parte
            // Más eficiente que hacer listen: true en todo el widget
            Consumer<FormularioProvider>(
              builder: (context, prov, _) {
                // Generamos un CheckboxListTile por cada deporte de la lista
                return Column(
                  children: _deportes.map((deporte) {
                    return CheckboxListTile(
                      title: Text(deporte),
                      // Marcado si el deporte ya está en la lista del provider
                      value: prov.deportesFavoritos.contains(deporte),
                      onChanged: (bool? value) {
                        // Llamamos al provider para añadir o quitar el deporte
                        prov.toggleDeporte(deporte, value ?? false);
                      },
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 24),

            // ---- BOTÓN ENVIAR ----
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de resultados usando la ruta nombrada
                  // Los datos ya están guardados en el provider, no hace falta pasarlos
                  Navigator.pushNamed(context, '/resultados');
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