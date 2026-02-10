import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static late SharedPreferences _preferencias;

  //Aqui creo las propiedades globales que quiero manejar
  static String _nombre = '';
  static bool _isDarkMode = false;
  static bool _userLocation = false;
  static bool _camaraPermiso = false;

  static Future init() async{
    _preferencias = await SharedPreferences.getInstance();
  }

  //Me creo los metodos que me devolveran los valores
  static get nombre{
    //si no existe muestra el nombre que he creado arriba
    return _preferencias.getString('nombre') ?? _nombre;
  }

  static set nombre(String nombre){
    _nombre = nombre;
    _preferencias.setString('nombre', nombre);
  }

  static get ubicacion{
    return _preferencias.getBool('localizacion') ?? _userLocation;
  }

  static set ubicacion(bool ubicacion){
    _userLocation = ubicacion;
    _preferencias.setBool('localizacion', _userLocation);
  }

  static get camara{
    return _preferencias.getBool('camara') ?? _camaraPermiso;
  }

  static set camara(bool ubicacion){
    _userLocation = ubicacion;
    _preferencias.setBool('camara', _camaraPermiso);
  }

  static get isDark{
    return _preferencias.getBool('modo_oscuro') ?? _isDarkMode;
  }

  static set isDark(bool isDark){
    _isDarkMode = isDark;
    _preferencias.setBool('modo_oscuro', _isDarkMode);
  }

}