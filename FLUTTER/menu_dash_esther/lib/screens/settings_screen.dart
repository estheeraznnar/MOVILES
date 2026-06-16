import 'package:flutter/material.dart';
import 'package:menu_dash/config/preferences/preferencias.dart';

// Pantalla de ajustes de usuario
// Lee y guarda valores persistentes usando la clase Preferencias

class SettingsScreen extends StatefulWidget {
   
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 /* bool _isDarkMode = false;
  bool _userLocation = false;
  bool _camaraPermiso = false;
  String _nombre = 'Esther';*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),), 
      body: SingleChildScrollView(
        child: Column(
          children: [

            CheckboxListTile.adaptive(
              title: Text('Permiso de ubicacion'),
              value: /*_userLocation*/Preferencias.ubicacion, 
              onChanged: (value){
                  setState(() {
                    //con el check box hay que poner value! no value simpre
                    //_userLocation =! _userLocation;

                    Preferencias.ubicacion = value!;
                  });
              },
            ),
            SwitchListTile.adaptive(
              title: Text('Permiso de camara'),
              value: /*_camaraPermiso*/ Preferencias.camara, 
              onChanged: (value){
                setState(() {
                    //_camaraPermiso = value;
                    Preferencias.camara = value!;
                  });
              },
            ),
            SwitchListTile.adaptive(
              title: Text('DarkMode'),
              value: /*_isDarkMode*/ Preferencias.isDark, 
              onChanged: (value){
                setState(() {
                    Preferencias.isDark = value!;
                    //_isDarkMode = value;
                  });
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: Preferencias.nombre,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre del usuario'
                ),
                onChanged: (value){
                  Preferencias.nombre = value;
                  //_nombre=value;
                },
              ),
            )
          ],
        ),
      )
    );
  }
}