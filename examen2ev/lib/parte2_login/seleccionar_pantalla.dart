import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';
import 'login_screen.dart';
import '../parte3_menu/menu_screen.dart';

/// Pantalla que se muestra al iniciar la App.
/// Comprueba (escuchando el estado de Firebase Auth) si el usuario está
/// logueado: si lo está, muestra el Menú; si no, muestra el Login.
class SeleccionarPantalla extends StatelessWidget {
  const SeleccionarPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Mientras se comprueba el estado, mostramos un indicador de carga.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si hay usuario en el snapshot, está logueado -> Menú.
        if (snapshot.hasData) {
          return const MenuScreen();
        }

        // Si no hay usuario, no está logueado -> Login.
        return const LoginScreen();
      },
    );
  }
}
