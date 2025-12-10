import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {  
  int _contador = 0;
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(_contador.toString(), style: TextStyle(fontSize: 120),),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _contador++;
                });
              }, 
              child: Text('Incrementar')
              )
          ],
        ),
      );
  }
}