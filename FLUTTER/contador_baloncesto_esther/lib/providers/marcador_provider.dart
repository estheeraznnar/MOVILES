import 'package:flutter/material.dart';

class MarcadorProvider extends ChangeNotifier {
  int _puntosLocal = 0;
  int _puntosVisitante = 0;

  int get puntosLocal => _puntosLocal;
  int get puntosVisitante => _puntosVisitante;

  void sumarPuntosLocal(int puntos) {
    _puntosLocal += puntos;
    notifyListeners();
  }

  void restarPuntosLocal() {
    if (_puntosLocal > 0) {
      _puntosLocal--;
      notifyListeners();
    }
  }

  void sumarPuntosVisitante(int puntos) {
    _puntosVisitante += puntos;
    notifyListeners();
  }

  void restarPuntosVisitante() {
    if (_puntosVisitante > 0) {
      _puntosVisitante--;
      notifyListeners();
    }
  }

  void reiniciarMarcador() {
    _puntosLocal = 0;
    _puntosVisitante = 0;
    notifyListeners();
  }

  String obtenerResultado() {
    if (_puntosLocal > _puntosVisitante) {
      return 'Gana Local';
    } else if (_puntosVisitante > _puntosLocal) {
      return 'Gana Visitante';
    } else {
      return 'Fue un empate';
    }
  }
}
