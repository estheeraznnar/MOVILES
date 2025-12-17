import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {

  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.ac_unit)), //Icono antes de empezar el titulo
        title: Text('Counter Functions Screen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings)), //Icono detras del titulo
        ],
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' $contador ', style: TextStyle( fontSize: 160, fontWeight:FontWeight.w100 ),),
              Text('Click${contador==1 ? '' : 's'}', style: TextStyle(fontSize: 25),),
            ],
          ),
        ),
        floatingActionButton: Column( //Pone los botones en una columna usando wrap whith
          mainAxisAlignment: MainAxisAlignment.end, //Pone los botones abajo
          children: [
            BotonPersonalizado( //Boton personalizado creado desde Extract widgect
              icono:  Icons.refresh_rounded, //El icono que quiero que salga en el boton
              onPressed: (){ //La funcion que quiero que haga el boton
                setState(() {
                  contador = 0;
                });
              },
            ),
            SizedBox(height: 10,), //la separacion de altura entre los botones
            BotonPersonalizado(
              icono:  Icons.plus_one,
              onPressed: (){
                setState(() {
                  contador ++;
                });
              },
            ),
            SizedBox(height: 10,),
            BotonPersonalizado(
              icono:  Icons.exposure_minus_1,
              onPressed: (){
                setState(() {
                  if( contador == 0) return; //Si el contador llega a cero no deja seguir bajando 
                  contador --;
                });
              },
            ),
          ],
        ),
      );
  }
}

class BotonPersonalizado extends StatelessWidget {

  final IconData icono; //creo el icono que quiero que vaya en los botones
  final VoidCallback? onPressed; //callbak opcional porque puede ser nula

  const BotonPersonalizado({super.key, required this.icono, this.onPressed}); //constante del boton con el icono

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      enableFeedback: true, //En aple pone vibracion y en android sonido o vibracion
      elevation: 10, //La sombra del boton como seria graficamente
      //shape: Border.all(), //Les pone un reborde en negro y los pone mas cuadrados
      backgroundColor: const Color.fromARGB(255, 121, 161, 122),
      child: Icon( icono), //Esto es el nombre de lo que le tengo que pasar a los botones
        onPressed: onPressed //Funcion callback hace lo que tengo en el onPressed
        
      );
  }
}