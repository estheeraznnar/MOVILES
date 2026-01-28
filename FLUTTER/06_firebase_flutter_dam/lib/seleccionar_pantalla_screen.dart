import 'package:firebase_flutter_dam/screens/home_screen.dart';
import 'package:firebase_flutter_dam/screens/login_screen.dart';
import 'package:firebase_flutter_dam/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeleccionarScreen extends StatelessWidget {
  const SeleccionarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return StreamBuilder<User?>(
      //Escucha los cambios de estado de autenticacion
      stream: authService.authStateChanges, 
      builder: (context, snapshot) {
        //Mientras se esta verificando el estado:
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive(),),
          );
        }
        //si hay un error 
        if(snapshot.hasError){
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}'),),
          );
        }
        //Si el susario esta logueado
        if(snapshot.hasData ){
          return HomeScreen();
        }
        //No hay usuario logueado
        return LoginScreen();
      },
    );
  }
}