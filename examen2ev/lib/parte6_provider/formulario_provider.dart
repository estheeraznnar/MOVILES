import 'package:flutter/material.dart';

/// Gestor de estado del formulario. Va almacenando los valores que el
/// usuario introduce para que puedan mostrarse en cualquier parte de la
/// aplicación (p. ej. en ResultadoScreen). Al estar por encima del
/// Navigator, los datos se mantienen durante todo el uso de la app.
class FormularioProvider extends ChangeNotifier {
  String _nombre = '';
  String _edad = '';
  final Set<String> _deportes = {};

  // Opciones disponibles de deportes.
  static const List<String> deportesDisponibles = [
    'Fútbol',
    'Baloncesto',
    'Tenis',
  ];

  String get nombre => _nombre;
  String get edad => _edad;
  Set<String> get deportes => _deportes;

  set nombre(String valor) {
    _nombre = valor;
    notifyListeners();
  }

  set edad(String valor) {
    _edad = valor;
    notifyListeners();
  }

  /// Devuelve true si un deporte está seleccionado.
  bool tieneDeporte(String deporte) => _deportes.contains(deporte);

  /// Marca o desmarca un deporte.
  void toggleDeporte(String deporte, bool seleccionado) {
    if (seleccionado) {
      _deportes.add(deporte);
    } else {
      _deportes.remove(deporte);
    }
    notifyListeners();
  }
}
