import 'package:componentes_02/config/rutas/menu_items.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),),
        /*body: Center(
          child: Text('Home Screen'),
        ),*/
        body: Container(
          color: const Color.fromARGB(255, 233, 255, 234),//Pone color de fondo
          child: ListView.builder(
            itemCount: menuItems.length, //poner cuantas repeticiones quiero
            itemBuilder: (context, index){
              //return Text('Hola a Dam2 en la posicion $index'); //me hace una cadena sin fin de lo que le pongo
              final menuItem = menuItems[index];
              final colors = Theme.of(context).colorScheme; //llama a la lista de colores que me cree
                                                            //pero coge el color que seleccionamos en
                                                            //el main


              return ListTile(
                title: Text( menuItem.titulo), //El titulo que tengo en la clase de menu items
                subtitle: Text( menuItem.subtitulo), //El subtitulo
                leading: Icon(menuItem.icono, color: colors.primary,), //El icono y el color
                trailing: Icon(Icons.arrow_forward_ios, color: colors.primary,), //Pone las flechas y el color
                onTap: (){
                  //Navegar a otra pantalla
                  /*Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BotonesScreen(),
                      )
                  );*/
                  Navigator.pushNamed(context, menuItem.link); //Es lo de arriba pero va a la 
                                                              //vista que quiero usando el link 
                                                              //puesto en el menuItem
                  
                },
              );
            }
          ),
        ),
    );
  }
}