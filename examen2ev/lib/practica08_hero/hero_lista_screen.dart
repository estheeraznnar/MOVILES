import 'package:flutter/material.dart';

import 'hero_detalle_screen.dart';
import 'hero_item.dart';

/// Pantalla principal de la Práctica 8 (widget Hero). Muestra una lista de
/// elementos; al pulsar uno, su icono se anima (vuela) hasta el detalle.
class HeroListaScreen extends StatelessWidget {
  const HeroListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 8 · Hero')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: heroItems.length,
        itemBuilder: (_, i) {
          final item = heroItems[i];
          return Card(
            child: ListTile(
              // El Hero envuelve el avatar con el mismo tag que el detalle.
              leading: Hero(
                tag: item.tag,
                child: CircleAvatar(
                  backgroundColor: item.color,
                  child: Icon(item.icono, color: Colors.white),
                ),
              ),
              title: Text(item.titulo),
              subtitle: const Text('Pulsa para ver la animación Hero'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HeroDetalleScreen(item: item),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
