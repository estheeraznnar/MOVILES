import 'package:flutter/material.dart';

import '../parte1_rutas/app_routes.dart';
import '../parte2_login/auth_service.dart';
import 'menu_boton.dart';

/// Pantalla de menú principal: muestra una cuadrícula de botones (3 por fila)
/// para navegar a cada sección de la app, más la opción de cerrar sesión.
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Email del usuario actualmente conectado en Firebase.
    final email = AuthService().usuarioActual?.email ?? 'Sin sesión';

    return Scaffold(
      appBar: AppBar(title: const Text('Menú')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Email del usuario conectado
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Conectado: $email',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Filas 1 y 2: las 6 opciones originales (3 por fila)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                // Fila 1
                MenuBoton(
                  icono: Icons.cloud,
                  texto: 'API Rest',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.peliculas),
                ),
                MenuBoton(
                  icono: Icons.edit_document,
                  texto: 'Formulario',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.formulario),
                ),
                MenuBoton(
                  icono: Icons.list_alt,
                  texto: 'Resultados Provider',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.resultado),
                ),
                // Fila 2
                MenuBoton(
                  icono: Icons.settings,
                  texto: 'Preferencias',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.preferencias),
                ),
                MenuBoton(
                  icono: Icons.people,
                  texto: 'Empleados',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.empleados),
                ),
                MenuBoton(
                  icono: Icons.logout,
                  texto: 'Logout',
                  onTap: () => AuthService().logout(context),
                ),
              ],
            ),

            // Línea separadora entre la fila 2 y la fila 3
            const Divider(
              thickness: 2,
              indent: 16,
              endIndent: 16,
            ),

            // Título de la sección de prácticas
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'PRÁCTICAS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Fila 3: opción de navegación (Práctica 07)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                MenuBoton(
                  icono: Icons.alt_route,
                  texto: 'Navegación',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.nav1),
                ),
                MenuBoton(
                  icono: Icons.animation,
                  texto: 'Práctica 8',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.practica8),
                ),
                MenuBoton(
                  icono: Icons.sports_basketball,
                  texto: 'Práctica 9',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.practica9),
                ),
                MenuBoton(
                  icono: Icons.tv,
                  texto: 'Práctica 12',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.practica12),
                ),
                MenuBoton(
                  icono: Icons.shopping_cart,
                  texto: 'Práctica 13',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.practica13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
