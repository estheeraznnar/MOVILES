import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeleccionarPantalla extends StatelessWidget {
  const SeleccionarPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // StreamBuilder escucha en tiempo real el estado de autenticación de Firebase
      // Cada vez que el usuario se loguea o desloguea, se reconstruye el widget
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // Estado de espera: Firebase todavía está comprobando si hay usuario
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si ocurre algún error con Firebase mostramos el mensaje
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        // snapshot.hasData significa que hay un usuario logueado
        if (snapshot.hasData) {
          // addPostFrameCallback espera a que el widget esté construido
          // para poder mostrar el snackbar y navegar
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Mostramos snackbar informando que hay sesión activa
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuario logueado')),
            );
          });
          // Redirigimos a home con el widget auxiliar
          return const HomeRedirect();
        }

        // Si no hay usuario logueado (snapshot sin datos)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Avisamos con snackbar que no hay sesión
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario no logueado')),
          );
          // Volvemos al login sin posibilidad de volver atrás
          Navigator.pushReplacementNamed(context, '/login');
        });

        // Mientras redirige mostramos el loading
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// Widget auxiliar para redirigir a home después de confirmar el login
class HomeRedirect extends StatefulWidget {
  const HomeRedirect({super.key});

  @override
  State<HomeRedirect> createState() => _HomeRedirectState();
}

class _HomeRedirectState extends State<HomeRedirect> {
  @override
  void initState() {
    super.initState();
    // initState se ejecuta al crear el widget
    // Esperamos a que el frame esté listo para navegar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mientras navegamos mostramos el loading
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}