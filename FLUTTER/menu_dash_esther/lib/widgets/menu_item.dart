import 'package:flutter/material.dart';
import 'package:menu_dash/widgets/option_menu_item.dart';

//widget visual que recibe un OptionMenuItem 
//Tarjeta visual del menu principal
//Usa los datos de una opcion y navega a su ruta al pulsar
class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required OptionMenuItem opcion,
  }) : _opcion = opcion;

  final OptionMenuItem _opcion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //Para que sea clickable
      onTap: () => Navigator.pushNamed(context, _opcion.screenName),
      child: Card(
        elevation: 5, //cuanto de elevado quiero
        color: _opcion.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _opcion.iconData, 
              color: const Color.fromARGB(255, 65, 59, 59), 
              size: 50,
            ),
            SizedBox(height: 15), //separacion entre el icono y el texto
            Text(
              _opcion.texto, 
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 59, 59), 
                fontSize: 17, 
                fontWeight: FontWeight.bold
              ), 
            )
          ],
        )
      ),
    );
  }
}