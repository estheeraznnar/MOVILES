import 'package:cloud_firestore/cloud_firestore.dart';

import 'empleado.dart';

/// Servicio que obtiene los empleados de la colección 'empleados' de Firestore.
class EmpleadosService {
  final CollectionReference _coleccion =
      FirebaseFirestore.instance.collection('empleados');

  /// Devuelve un stream con la lista de empleados, que se actualiza
  /// automáticamente cuando cambia la colección en Firestore.
  Stream<List<Empleado>> getEmpleados() {
    return _coleccion.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Empleado.fromFirestore(doc)).toList(),
    );
  }
}
