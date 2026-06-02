import 'package:flutter/material.dart';

// ChangeNotifier permite notificar a los widgets cuando cambian los datos
// Es la clase base del patrón Provider en Flutter
class FormularioProvider extends ChangeNotifier {

  // ---- PROPIEDADES QUE ALMACENA EL PROVIDER ----
  // Estos valores persisten mientras la app esté abierta (en memoria)

  // Nombre introducido por el usuario en el formulario
  String nombre = '';

  // Edad introducida por el usuario en el formulario
  int edad = 0;

  // Lista de deportes que el usuario ha marcado con checkbox
  List<String> deportesFavoritos = [];

  // ---- MÉTODOS SETTER ----
  // Cada setter actualiza el valor y llama a notifyListeners()
  // notifyListeners() avisa a todos los widgets que escuchan este provider
  // para que se reconstruyan con los nuevos datos

  // Actualiza el nombre cuando el usuario escribe en el TextField
  void setNombre(String value) {
    nombre = value;
    notifyListeners(); // reconstruye los widgets que usan Consumer<FormularioProvider>
  }

  // Actualiza la edad cuando el usuario escribe en el TextField de edad
  void setEdad(int value) {
    edad = value;
    notifyListeners(); // reconstruye los widgets que usan Consumer<FormularioProvider>
  }

  // Añade o elimina un deporte de la lista según el estado del checkbox
  // seleccionado=true  → el usuario ha marcado el checkbox → añadimos el deporte
  // seleccionado=false → el usuario ha desmarcado el checkbox → eliminamos el deporte
  void toggleDeporte(String deporte, bool seleccionado) {
    if (seleccionado) {
      deportesFavoritos.add(deporte);    // añadimos a la lista
    } else {
      deportesFavoritos.remove(deporte); // eliminamos de la lista
    }
    notifyListeners(); // reconstruye los checkboxes para reflejar el cambio
  }
}