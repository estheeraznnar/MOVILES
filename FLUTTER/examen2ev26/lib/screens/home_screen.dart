import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:examen2ev26/services/auth_service.dart';

// StatefulWidget porque necesitamos initState para mostrar el snackbar al cargar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Instancia del servicio de autenticación
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Esperamos a que el widget esté construido para mostrar el snackbar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _comprobarUsuario();
    });
  }

  // Comprueba si hay usuario logueado y muestra un snackbar con el resultado
  void _comprobarUsuario() {
    // currentUser devuelve el usuario actual o null si no hay sesión
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Mostramos el email del usuario logueado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario logueado: ${user.email}')),
      );
    } else {
      // No hay ningún usuario con sesión activa
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay usuario logueado')),
      );
    }
  }

  // Cierra la sesión y redirige al login
  Future<void> _logout() async {
    await _authService.logout(); // Llamamos al método del servicio
    // pushReplacementNamed evita que el usuario pueda volver atrás
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  // Método auxiliar que construye cada botón del menú
  // Recibe el texto, el icono y la ruta a la que navegar
  Widget _menuBoton(String texto, IconData icono, String ruta) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Fondo azul como en el diseño
        foregroundColor: Colors.white, // Icono y texto en blanco
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Bordes redondeados
        ),
        padding: const EdgeInsets.all(16),
      ),
      // Navegamos a la ruta indicada al pulsar el botón
      onPressed: () => Navigator.pushNamed(context, ruta),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 32), // Icono grande centrado
          const SizedBox(height: 8),
          Text(texto, textAlign: TextAlign.center), // Texto debajo del icono
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen DAM 2'),
        actions: [
          // Botón de logout en la esquina superior derecha
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 3, // 3 columnas = 2 filas de 3 botones
          crossAxisSpacing: 16, // Espacio horizontal entre botones
          mainAxisSpacing: 16,  // Espacio vertical entre botones
          children: [
            // Primera fila
            _menuBoton('Api REST', Icons.play_arrow, '/peliculas'),
            _menuBoton('Formulario', Icons.description, '/formulario'),
            _menuBoton('Resultados\nProvider', Icons.link, '/resultados'),
            // Segunda fila
            _menuBoton('Preferencias', Icons.settings, '/preferencias'),
            _menuBoton('Empleados', Icons.group, '/empleados'),
            // Botón logout construido aparte porque no navega sino que cierra sesión
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
              ),
              onPressed: _logout,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, size: 32),
                  SizedBox(height: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}