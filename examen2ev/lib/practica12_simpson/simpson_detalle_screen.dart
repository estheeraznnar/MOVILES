import 'package:flutter/material.dart';

import 'simpson_personaje.dart';

/// Vista de detalle de un personaje: muestra su imagen grande y la mayoría
/// de sus datos (ocupación, edad, género, estado, nacimiento y una frase).
class SimpsonDetalleScreen extends StatelessWidget {
  final SimpsonPersonaje personaje;

  const SimpsonDetalleScreen({super.key, required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personaje.name),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen del personaje sobre fondo amarillo
            Container(
              width: double.infinity,
              color: Colors.amber.shade100,
              padding: const EdgeInsets.all(16),
              child: Image.network(
                personaje.imagenUrl,
                height: 250,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, size: 150),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personaje.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 32),
                  _Dato(icono: Icons.work, etiqueta: 'Ocupación', valor: personaje.occupation),
                  _Dato(
                    icono: Icons.cake,
                    etiqueta: 'Edad',
                    valor: personaje.age?.toString() ?? 'Desconocida',
                  ),
                  _Dato(icono: Icons.wc, etiqueta: 'Género', valor: personaje.gender),
                  _Dato(
                    icono: Icons.favorite,
                    etiqueta: 'Estado',
                    valor: personaje.status,
                  ),
                  _Dato(
                    icono: Icons.calendar_today,
                    etiqueta: 'Nacimiento',
                    valor: personaje.birthdate ?? 'Desconocido',
                  ),
                  if (personaje.phrases.isNotEmpty) ...[
                    const Divider(height: 32),
                    const Text(
                      'Frase célebre',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"${personaje.phrases.first}"',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila "icono · etiqueta: valor" para un dato del personaje.
class _Dato extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String valor;

  const _Dato({
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icono, color: Colors.amber.shade800),
          const SizedBox(width: 12),
          Text(
            '$etiqueta: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
