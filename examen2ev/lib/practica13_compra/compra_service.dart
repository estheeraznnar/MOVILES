import 'package:cloud_firestore/cloud_firestore.dart';

import 'producto.dart';

/// Servicio que gestiona la lista de la compra en Firestore (colección
/// 'lista_compra'): obtener, añadir, editar y eliminar productos.
class CompraService {
  final CollectionReference _coleccion =
      FirebaseFirestore.instance.collection('lista_compra');

  /// Stream con la lista de productos en tiempo real.
  Stream<List<Producto>> getProductos() {
    return _coleccion.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList(),
    );
  }

  /// Añade un producto nuevo, guardando también el usuario que lo añade.
  Future<void> anadirProducto(
    String nombre,
    int cantidad,
    String usuario,
  ) {
    return _coleccion.add({
      'nombre': nombre,
      'cantidad': cantidad,
      'usuario': usuario,
    });
  }

  /// Edita el nombre y la cantidad de un producto existente.
  Future<void> editarProducto(String id, String nombre, int cantidad) {
    return _coleccion.doc(id).update({
      'nombre': nombre,
      'cantidad': cantidad,
    });
  }

  /// Elimina un producto de la lista.
  Future<void> eliminarProducto(String id) {
    return _coleccion.doc(id).delete();
  }
}
