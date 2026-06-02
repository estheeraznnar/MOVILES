import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo de un empleado de la colección 'empleados' de Firestore.
class Empleado {
  final String id;
  final int anioNacimiento;
  final String apellidos;
  final String nombre;
  final bool responsable;

  Empleado({
    required this.id,
    required this.anioNacimiento,
    required this.apellidos,
    required this.nombre,
    required this.responsable,
  });

  /// Crea un Empleado a partir de un documento de Firestore.
  factory Empleado.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Empleado(
      id: doc.id,
      anioNacimiento: (data['anioNacimiento'] as num?)?.toInt() ?? 0,
      apellidos: data['apellidos'] ?? '',
      nombre: data['nombre'] ?? '',
      responsable: data['responsable'] ?? false,
    );
  }
}
