import 'package:flutter/material.dart';

class BotonesScreen extends StatelessWidget {
  const BotonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Botones'),),
      body: _BotonesScreenView(), //Extraigo el body
      floatingActionButton: FloatingActionButton( //El boton situado abajo
        child: Icon(Icons.arrow_back_ios),
        onPressed: (){
          Navigator.pop(context); //Me lleva a la pagina de antes
        },
      ),
    );
  }
}

class _BotonesScreenView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, //que todo el contenedor ocupe todo el ancho
      child: Padding( //Al envolver la columna aqui le pone el padding y sus propiedades
        padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 10), //Le pongo el pading que quiera
                                                                            //En el wrap no funciona
        /*child: Column( //Los pone un lado al otro y cuando no cabe lo pasa abajo
          children: [
            ElevatedButton(
              onPressed: (){  }, 
              child: Text('elevatedButton')
            ),
            ElevatedButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              onPressed: () { }, 
              label: Text('Elevated icon button'),
              icon: Icon(Icons.access_alarm_outlined),
            ),
             FilledButton(
              onPressed: () { }, 
              child: Text('FiledButton')
            ),
             FilledButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              onPressed: () { }, 
              label: Text('Elevated icon button'),
              icon: Icon(Icons.access_time_filled_outlined),
            )
          ],
        ),*/
        child: Wrap( //Los pone un lado al otro y cuando no cabe lo pasa abajo
        spacing: 14, //es el pading de whrap
        alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){  }, 
              child: Text('elevatedButton')
            ),
            ElevatedButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              onPressed: () { }, 
              label: Text('Elevated icon button'),
              icon: Icon(Icons.access_alarm_outlined),
            ),
             FilledButton(
              onPressed: () { }, 
              child: Text('FiledButton')
            ),
             FilledButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              iconAlignment: IconAlignment.end, //que el icono salga al final
              onPressed: () { }, 
              label: Text('Elevated icon button'),
              icon: Icon(Icons.access_time_filled_outlined),
            ),
            OutlinedButton(
              onPressed: () { }, 
              child: Text('Outlined Button')
            ),
            OutlinedButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              onPressed: () { }, 
              label: Text('Outlined icon button'),
              icon: Icon(Icons.accessible_forward_outlined),
            ),
            TextButton(
              onPressed: () { }, 
              child: Text('Text Button')
            ),
            TextButton.icon( //se diferencia al otro en que en este le puedo poner un icono
              onPressed: () { }, 
              label: Text('Outlined icon button'),
              icon: Icon(Icons.account_box_outlined),
            ),
            IconButton( //Es un icono simplemente
              onPressed: () { }, 
              icon: Icon(Icons.account_balance_wallet_sharp),
              color: const Color(0xFF9C27B0),
            ),
          ],
        ),
      ),
    );
  }
}