import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instancia de firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Instancia de google sing in
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance; 
  static bool isInitialize = false;

  //Me creo un screen para que permita cambios en el estado de autenticacion
    //Algo a lo que estas suscrito durante el uso de la aplicacion
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  //para obtener el usuario actual
  User? get currenUser => _auth.currentUser;

    ///////////////////////////////////////////////
    ///Registro con email y contraseña//////
    /////////////////////////////////////////////
  Future<UserCredential?> registroConEmailYContrasena({
    //required String nombre,
    required String email,
    required String password,
  }) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }on FirebaseAuthException catch(e){
      //Manejo de errores especificos en Firebase
      if(e.code == 'email-already-in-use'){
        throw Exception('Este email ya esta registrado');
      }else if(e.code == 'invalid-email'){
        throw Exception('Este email no es valido');
      }
      throw Exception('Error al registrar el usuario: ${e.message}');
    }
    catch(e){
      throw Exception('Error inesperado: $e');
    }
  }

  ///////////////////////////////////////////////
  ///Iniciar sesion con email y contraseña//////
  /////////////////////////////////////////////
  
  Future<UserCredential?> iniciarSesion({
    required String email,
    required String password,
  }) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }on FirebaseAuthException catch(e){
      //Manejo de errores especificos en Firebase
      if(e.code == 'email-not-found'){
        throw Exception('Este email no encontrado');
      }else if(e.code == 'wrong-password'){
        throw Exception('Contraseña Incorrecta');
      }
      throw Exception('Error al iniciar sesion: ${e.message}');
    }
    catch(e){
      throw Exception('Error inesperado: $e');
    }
  }


  /////////////////////////////////////
  ///Cerrar sesion ///////////////////
  ////////////////////////////////////
  
  Future<void> cerrarSesion() async{
    try{
      await _auth.signOut();
    }catch (e){
      throw Exception('Error al cerrar la sesion: $e');
    }
  }

  ///////////////////////////////////////////////
  ///Iniciar sesion con google            //////
  /////////////////////////////////////////////
  
  Future<void> initSignIn() async{
    if(!isInitialize){
      await _googleSignIn.initialize(
        serverClientId: 
      );
    }
  }

}