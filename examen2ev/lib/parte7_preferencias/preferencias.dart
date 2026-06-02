import 'package:shared_preferences/shared_preferences.dart';

/// Almacén global de preferencias del usuario usando shared_preferences.
/// Guarda los valores en el dispositivo, de modo que persisten aunque se
/// cierre y se vuelva a abrir la aplicación.
class Preferencias {
  static late SharedPreferences _prefs;

  /// Inicializa shared_preferences. Hay que llamarlo en main() antes de
  /// usar cualquier propiedad.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- Nombre ---
  static String get nombre => _prefs.getString('nombre') ?? '';
  static set nombre(String valor) => _prefs.setString('nombre', valor);

  // --- Edad ---
  static String get edad => _prefs.getString('edad') ?? '';
  static set edad(String valor) => _prefs.setString('edad', valor);

  // --- Deportes favoritos ---
  static List<String> get deportes => _prefs.getStringList('deportes') ?? [];
  static set deportes(List<String> valor) =>
      _prefs.setStringList('deportes', valor);
}
