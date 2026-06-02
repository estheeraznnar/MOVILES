import 'package:firebase_auth/firebase_auth.dart';
//TODO parte2 :Ejercicio2
// Servicio que centraliza toda la lógica de autenticación con Firebase
class AuthService {
  // Instancia de FirebaseAuth para usar en todos los métodos
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para registrar un nuevo usuario con email y contraseña
  Future<User?> registroEnFirebase(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user; // Devuelve el usuario creado
    } catch (e) {
      return null; // Si hay error devuelve null
    }
  }

  // Método para hacer login con un usuario ya existente
  Future<User?> loginEnFirebase(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user; // Devuelve el usuario logueado
    } catch (e) {
      return null; // Si hay error devuelve null
    }
  }

  // Método para cerrar la sesión del usuario actual
  Future<void> logout() async {
    await _auth.signOut();
  }
}