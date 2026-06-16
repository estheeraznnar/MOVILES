import 'package:flutter/material.dart';
import 'package:menu_dash/config/menu/menu_items.dart';
import 'package:menu_dash/config/preferences/preferencias.dart';
import 'package:menu_dash/widgets/menu_item.dart';
import 'package:menu_dash/widgets/option_menu_item.dart';

// pantalla principal del menú o home
// Pide la lista a MenuItems().listOptionMenuItem y la muestra con GridView.builder
// Recorre la lista de opciones y crea una cuadrícula navegable

class MenuScreen extends StatelessWidget {
   
  const MenuScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //uso OptionMenuItem como modelo y MenuItem para dibujar cada tarjeta
    final List<OptionMenuItem> _listaOpcionesMenu = MenuItems().listOptionMenuItem;

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido ' + Preferencias.nombre),), 
      body: Padding( //pone bordes
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _listaOpcionesMenu.length, //esto se puede ir cambiando conforme los cards que vayas necesitando 
                                                //si es una lista creada arriba pone los que contenga esa lista
          //Griddelegate sirve para personalizar el comportamiento del Grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //cuantos items quiero por linea
            crossAxisSpacing: 8.0, //separacion en medio
            mainAxisSpacing: 8.0, //separacion debajo
          ),
          //constructor que construye el menu conforme una lista de algo 
          itemBuilder: (context, index){

            final OptionMenuItem _opcion = _listaOpcionesMenu[index];
            return MenuItem(opcion: _opcion);
          }
        ),
      )
    );
  }
}


