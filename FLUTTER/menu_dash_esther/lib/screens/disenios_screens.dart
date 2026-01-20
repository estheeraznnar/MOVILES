import 'package:flutter/material.dart';
import 'package:menu_dash/widgets/header_widget.dart';
import 'package:menu_dash/widgets/lista_personajes_widgets.dart';

class DiseniosScreens extends StatelessWidget {
   
  const DiseniosScreens({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 42, 42),
      body: Column(
        children: [
          HeaderWidget(),
          ListaPersonajesWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: const Color.fromARGB(255, 129, 187, 151),
        child: Icon(Icons.add),
      ),
    );
  }
}
