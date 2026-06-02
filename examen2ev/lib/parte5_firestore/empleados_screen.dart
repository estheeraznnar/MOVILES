import 'package:flutter/material.dart';

import 'empleado.dart';
import 'empleados_service.dart';

/// Pantalla que muestra en tiempo real la lista de empleados de la colección
/// 'empleados' de Firestore, con color e icono según si son responsables.
class EmpleadosScreen extends StatelessWidget {
  const EmpleadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final empleadosService = EmpleadosService();

    return Scaffold(
      appBar: AppBar(title: const Text('Empleados')),
      body: StreamBuilder<List<Empleado>>(
        stream: empleadosService.getEmpleados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final empleados = snapshot.data ?? [];
          if (empleados.isEmpty) {
            return const Center(child: Text('No hay empleados.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: empleados.length,
            itemBuilder: (_, i) => _EmpleadoTile(empleado: empleados[i]),
          );
        },
      ),
    );
  }
}

/// Fila de un empleado. El color de fondo y el icono dependen de si es
/// responsable (verde + check_circle) o no (rojo + cancel), con shade 100.
class _EmpleadoTile extends StatelessWidget {
  final Empleado empleado;

  const _EmpleadoTile({required this.empleado});

  @override
  Widget build(BuildContext context) {
    final bool esResponsable = empleado.responsable;
    final Color colorFondo =
        esResponsable ? Colors.green.shade100 : Colors.red.shade100;
    final IconData icono =
        esResponsable ? Icons.check_circle : Icons.cancel;
    final Color colorIcono = esResponsable ? Colors.green : Colors.red;

    return Card(
      color: colorFondo,
      child: ListTile(
        leading: Icon(icono, color: colorIcono, size: 36),
        title: Text('${empleado.nombre} ${empleado.apellidos}'),
        subtitle: Text('Año de nacimiento: ${empleado.anioNacimiento}'),
      ),
    );
  }
}
