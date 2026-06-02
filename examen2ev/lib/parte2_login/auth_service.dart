import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Servicio que centraliza la autenticación con Firebase Auth.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Stream que avisa cuando cambia el estado de sesión (login / logout).
  /// Lo usa SeleccionarPantalla para decidir qué pantalla mostrar.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Usuario actualmente autenticado (null si no hay sesión).
  User? get usuarioActual => _auth.currentUser;

  /// Registra un usuario nuevo con email y contraseña.
  /// Si falla, muestra un SnackBar con el error y devuelve null.
  Future<User?> registroEnFirebase(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      _mostrarSnackBar(context, _traducirError(e));
      return null;
    }
  }

  /// Inicia sesión con un usuario ya existente.
  /// Si falla, muestra un SnackBar con el error y devuelve null.
  Future<User?> loginEnFirebase(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      _mostrarSnackBar(context, _traducirError(e));
      return null;
    }
  }

  /// Cierra la sesión y avisa con un SnackBar.
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    _mostrarSnackBar(context, 'Has cerrado sesión correctamente.');
  }

  void _mostrarSnackBar(BuildContext context, String mensaje) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  String _traducirError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'El email no es válido.';
      case 'user-not-found':
        return 'No existe ningún usuario con ese email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email o contraseña incorrectos.';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con ese email.';
      case 'weak-password':
        return 'La contraseña es demasiado débil (mínimo 6 caracteres).';
      default:
        return e.message ?? 'Error de autenticación.';
    }
  }
}
