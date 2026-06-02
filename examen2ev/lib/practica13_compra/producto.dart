import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo de un producto de la lista de la compra (colección de Firestore).
class Producto {
  final String id;
  final String nombre;
  final int cantidad;
  final String usuario;

  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.usuario,
  });

  /// Crea un Producto a partir de un documento de Firestore.
  factory Producto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Producto(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      cantidad: (data['cantidad'] as num?)?.toInt() ?? 0,
      usuario: data['usuario'] ?? '',
    );
  }

  /// Convierte el producto a un mapa para guardarlo en Firestore.
  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'cantidad': cantidad,
    'usuario': usuario,
  };
}
