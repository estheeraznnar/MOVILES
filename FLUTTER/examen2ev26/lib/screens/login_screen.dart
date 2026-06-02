import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:examen2ev26/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para obtener el texto de los campos
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instancia del servicio de autenticación
  final AuthService _authService = AuthService();
  String _error = ''; // Mensaje de error si algo falla

  /*// Función para registrar un nuevo usuario en Firebase
  Future<void> _registro() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Si va bien navegamos a la pantalla principal
      if (mounted) Navigator.pushReplacementNamed(context, '/seleccionar');
    } catch (e) {
      setState(() => _error = 'Error al registrar el usuario');
    }
  }

  // Función para hacer login con Firebase
  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Si va bien navegamos a la pantalla principal sin poder volver
      if (mounted) Navigator.pushReplacementNamed(context, '/seleccionar');
    } catch (e) {
      setState(() => _error = 'Email o contraseña incorrectos');
    }
  }*/

   // Función de registro usando el AuthService
  Future<void> _registro() async {
    final user = await _authService.registroEnFirebase(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      // Si el registro va bien navegamos a la pantalla principal
      if (mounted) Navigator.pushReplacementNamed(context, '/seleccionar');
    } else {
      setState(() => _error = 'Error al registrar el usuario');
    }
  }

  // Función de login usando el AuthService
  Future<void> _login() async {
    final user = await _authService.loginEnFirebase(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (user != null) {
      // Si el login va bien navegamos a la pantalla principal
      if (mounted) Navigator.pushReplacementNamed(context, '/seleccionar');
    } else {
      setState(() => _error = 'Email o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Margen de 24px en todos los lados
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centramos verticalmente
          children: [
            // Logo de Flutter centrado
            const FlutterLogo(size: 80),
            const SizedBox(height: 32),
            // Campo email con icono
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Campo contraseña con icono - obscureText oculta los caracteres
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            // Solo muestra el error si hay alguno
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            // Botón de registro
            TextButton(
              onPressed: _registro,
              child: const Text('Registro en Firebase'),
            ),
            // Botón de login
            TextButton(
              onPressed: _login,
              child: const Text('Login con Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}