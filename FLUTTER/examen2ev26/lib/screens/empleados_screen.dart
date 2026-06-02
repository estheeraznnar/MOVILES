import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpleadosScreen extends StatefulWidget {
  const EmpleadosScreen({super.key});

  @override
  State<EmpleadosScreen> createState() => _EmpleadosScreenState();
}

class _EmpleadosScreenState extends State<EmpleadosScreen> {
  // TODO: Parte 5
  // Stream que escucha en tiempo real la colección 'empleados' de Firestore
  final Stream<QuerySnapshot> _empleadosStream =
      FirebaseFirestore.instance.collection('empleados').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empleados')),
      // StreamBuilder se actualiza automáticamente cuando cambian los datos
      body: StreamBuilder<QuerySnapshot>(
        stream: _empleadosStream,
        builder: (context, snapshot) {

          // Estado cargando: esperando la primera respuesta de Firestore
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Estado error: fallo en la conexión con Firestore
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Obtenemos la lista de documentos de la colección
          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              // Casteamos el documento a Map para acceder a sus campos
              final data = docs[index].data() as Map<String, dynamic>;

              final nombre = data['nombre'] ?? '';
              final apellidos = data['apellidos'] ?? '';
              final anioNacimiento = data['anioNacimiento'] ?? '';
              // responsable es boolean en Firestore
              final bool responsable = data['responsable'] ?? false;

              // Fondo verde shade 100 si responsable, rojo shade 100 si no
              final color = responsable
                  ? Colors.green.shade100
                  : Colors.red.shade100;

              // check_circle si responsable, cancel si no
              final icono = responsable
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red);

              return Container(
                color: color,
                child: ListTile(
                  leading: icono,
                  title: Text(
                    '$nombre $apellidos',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Año de Nacimiento: $anioNacimiento'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}