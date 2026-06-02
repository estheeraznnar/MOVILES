import 'package:flutter/material.dart';

import 'auth_service.dart';

/// Pantalla de login: muestra el logo de Flutter, los campos de email y
/// contraseña, y dos botones para registrarse o iniciar sesión en Firebase.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  bool _cargando = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  /// Botón "Registrarse": crea el usuario en Firebase y se loguea.
  Future<void> _registrar() async {
    if (!_camposValidos()) return;
    setState(() => _cargando = true);
    await _authService.registroEnFirebase(
      context,
      _emailCtrl.text,
      _passwordCtrl.text,
    );
    if (mounted) setState(() => _cargando = false);
    // Si el registro funciona, SeleccionarPantalla detecta el cambio de
    // sesión y muestra el Menú automáticamente. Si falla, el servicio
    // ya ha mostrado el SnackBar con el error.
  }

  /// Botón "Login": inicia sesión con un usuario ya existente.
  Future<void> _login() async {
    if (!_camposValidos()) return;
    setState(() => _cargando = true);
    await _authService.loginEnFirebase(
      context,
      _emailCtrl.text,
      _passwordCtrl.text,
    );
    if (mounted) setState(() => _cargando = false);
  }

  bool _camposValidos() {
    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rellena el email y la contraseña.')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo de Flutter
                const FlutterLogo(size: 120),
                const SizedBox(height: 40),

                // Campo email (teclado de correo)
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo password (oculto)
                TextField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),

                if (_cargando)
                  const CircularProgressIndicator()
                else ...[
                  // Botón registrarse + login en Firebase
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _registrar,
                      icon: const Icon(Icons.person_add),
                      label: const Text('Registrarse'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botón login con usuario existente
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _login,
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
