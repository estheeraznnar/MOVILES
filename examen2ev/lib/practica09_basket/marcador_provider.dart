import 'package:flutter/material.dart';

/// Gestor de estado del marcador de baloncesto. Guarda los puntos del equipo
/// local y visitante y la pestaña activa del BottomNavigationBar, de modo que
/// los valores se mantienen aunque cambiemos de vista o de pantalla.
class MarcadorProvider extends ChangeNotifier {
  int _puntosLocal = 0;
  int _puntosVisitante = 0;
  int _paginaActual = 0;

  int get puntosLocal => _puntosLocal;
  int get puntosVisitante => _puntosVisitante;
  int get paginaActual => _paginaActual;

  // --- Equipo local ---
  void sumarLocal(int puntos) {
    _puntosLocal += puntos;
    notifyListeners();
  }

  void restarLocal() {
    if (_puntosLocal > 0) _puntosLocal--;
    notifyListeners();
  }

  // --- Equipo visitante ---
  void sumarVisitante(int puntos) {
    _puntosVisitante += puntos;
    notifyListeners();
  }

  void restarVisitante() {
    if (_puntosVisitante > 0) _puntosVisitante--;
    notifyListeners();
  }

  /// Reinicia el marcador a 0 - 0.
  void reiniciar() {
    _puntosLocal = 0;
    _puntosVisitante = 0;
    notifyListeners();
  }

  /// Cambia la pestaña activa del BottomNavigationBar.
  void cambiarPagina(int indice) {
    _paginaActual = indice;
    notifyListeners();
  }
}
