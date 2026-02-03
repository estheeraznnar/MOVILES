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
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      //Manejo de errores especificos en Firebase
      if (e.code == 'email-already-in-use') {
        throw Exception('Este email ya esta registrado');
      } else if (e.code == 'invalid-email') {
        throw Exception('Este email no es valido');
      }
      throw Exception('Error al registrar el usuario: ${e.message}');
    } catch (e) {
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
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      //Manejo de errores especificos en Firebase
      if (e.code == 'email-not-found') {
        throw Exception('Este email no encontrado');
      } else if (e.code == 'wrong-password') {
        throw Exception('Contraseña Incorrecta');
      }
      throw Exception('Error al iniciar sesion: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  /////////////////////////////////////
  ///Cerrar sesion ///////////////////
  ////////////////////////////////////

  Future<void> cerrarSesion() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar la sesion: $e');
    }
  }

  ///////////////////////////////////////////////
  ///Iniciar sesion con google            //////
  /////////////////////////////////////////////

  Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '977425803362-3irqrpv3d3kgtmmd1dobe363tll4jkld.apps.googleusercontent.com',
      );
      isInitialize = true;
    }
  }

  //Iniciar sesion con Google 7.2.0
  Future<UserCredential?> loginConGoogle() async {
    try {
      //1- Iniciamos el servicio de Google Sing In
      ///Esto configura el ClientId del servidor necesario para autenticarnos
      initSignIn();
      //2-Autenticar el usuario con google: Abre la ventanita para seleccionar la cuenta
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Si el usuario cancela esa ventana, se podria retornar nulo
      if (googleUser == null) return null;

      //3- obtener el IdToken: es un token JWT que contiene la informacion del usuario
      final idToken = googleUser.authentication.idToken;

      //4- Obtenemos el cliente de autorizacion: Este cliente nos permire solicitar los permisos especificos
      final authorizationClient = googleUser.authorizationClient;

      //5- Solicitamos autorizacion para los scops email y porfile
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);

      //6- Obtenemos el accessToken
      final accesToken = authorization?.accessToken;

      //7-Validamos el token
      if (accesToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'porfile'],
        );
        //si tampoco funciona lanzamos un error
        if (authorization2?.accessToken != null) {
          throw FirebaseAuthException(code: 'Error CODIGO');
        }
        authorization = authorization2;
      }

      //8- Creamos las credenciales para firebase
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accesToken,
      );

      //9- Nos logueamos con firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      //10- Obtenemos el objeto user de  Firebas
      final User? user = userCredential.user;

      //11- Procesamos la informacion adicional del usuario
      if (user != null) {
        //Aqui podemos meter informacion en una base de datos de firebase
      }

      //12- Devolvemos las credenciales del usuario identificado
      return userCredential;
    
    } catch (e) {
      print('Error en logueo con google: $e');
    }

    //Si hubo algun error 
    return null;
  }
}
