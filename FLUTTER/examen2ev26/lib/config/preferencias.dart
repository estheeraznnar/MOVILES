import 'package:shared_preferences/shared_preferences.dart';

// TODO: Parte 7 - Ejercicio 2
// Clase singleton que gestiona SharedPreferences
// Singleton = solo existe una instancia en toda la app
class Preferencias {
  // Instancia estática de SharedPreferences — se inicializa una sola vez
  static late SharedPreferences _prefs;

  // Método que inicializa SharedPreferences — llamar en main() antes de runApp
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---- NOMBRE ----
  // Getter: devuelve el nombre guardado, o '' si no hay ninguno
  static String get nombre => _prefs.getString('nombre') ?? '';
  // Setter: guarda el nombre en disco
  static set nombre(String value) => _prefs.setString('nombre', value);

  // ---- EDAD ----
  // Getter: devuelve la edad guardada, o 0 si no hay ninguna
  static int get edad => _prefs.getInt('edad') ?? 0;
  // Setter: guarda la edad en disco
  static set edad(int value) => _prefs.setInt('edad', value);

  // ---- DEPORTES FAVORITOS ----
  // Getter: devuelve la lista de deportes guardada, o lista vacía
  static List<String> get deportesFavoritos =>
      _prefs.getStringList('deportesFavoritos') ?? [];
  // Setter: guarda la lista de deportes en disco
  static set deportesFavoritos(List<String> value) =>
      _prefs.setStringList('deportesFavoritos', value);
}