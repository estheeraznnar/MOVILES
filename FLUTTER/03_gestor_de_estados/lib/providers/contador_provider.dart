import 'package:flutter/material.dart';

//Este provider va a manejar el contador de la pagina 1
//ChangeNotifier es una clase que proporciona notificaciones a lo widgets cuando el estado cambia
class ContadorProvider extends ChangeNotifier{
  
  //se comparte con el resto
  int _contador = 0;

  //cuando tenemos un estado un provider hemos de poder hacer dos cosas
  //1.poder leer el valor de ese estado
  //2. poder modificar el valor de ese estado
  int get contador => _contador;

  void incrementar(){
    _contador ++;
    notifyListeners();
  }

  void decrementar(){
    _contador --;
    notifyListeners();
  }
  
}