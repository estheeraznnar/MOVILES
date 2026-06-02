import 'package:flutter/material.dart';

import '../parte2_login/auth_service.dart';
import 'compra_service.dart';
import 'producto.dart';

/// Pantalla de la lista de la compra (Práctica 13). Muestra los productos
/// guardados en Firestore y permite añadir, editar y eliminar, registrando
/// el usuario que añade cada producto.
class ListaCompraScreen extends StatelessWidget {
  const ListaCompraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compraService = CompraService();
    final usuario = AuthService().usuarioActual?.email ?? 'desconocido';

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de la compra')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogo(context, compraService, usuario),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Producto>>(
        stream: compraService.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final productos = snapshot.data ?? [];
          if (productos.isEmpty) {
            return const Center(
              child: Text('No hay productos. Pulsa + para añadir.'),
            );
          }

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (_, i) {
              final producto = productos[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${producto.cantidad}'),
                  ),
                  title: Text(producto.nombre),
                  subtitle: Text('Añadido por: ${producto.usuario}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Editar
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _mostrarDialogo(
                          context,
                          compraService,
                          usuario,
                          producto: producto,
                        ),
                      ),
                      // Eliminar
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            compraService.eliminarProducto(producto.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Muestra el diálogo para añadir (producto == null) o editar un producto.
  void _mostrarDialogo(
    BuildContext context,
    CompraService service,
    String usuario, {
    Producto? producto,
  }) {
    final esEdicion = producto != null;
    final nombreCtrl = TextEditingController(text: producto?.nombre ?? '');
    final cantidadCtrl = TextEditingController(
      text: producto != null ? '${producto.cantidad}' : '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(esEdicion ? 'Editar producto' : 'Nuevo producto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(labelText: 'Producto'),
            ),
            TextField(
              controller: cantidadCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final nombre = nombreCtrl.text.trim();
              final cantidad = int.tryParse(cantidadCtrl.text.trim()) ?? 1;
              if (nombre.isEmpty) return;

              if (esEdicion) {
                service.editarProducto(producto.id, nombre, cantidad);
              } else {
                service.anadirProducto(nombre, cantidad, usuario);
              }
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
