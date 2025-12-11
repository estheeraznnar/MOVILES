import 'package:flutter/material.dart';
import 'package:gestor_de_estados/providers/contador_provider.dart';
import 'package:provider/provider.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {  
  
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(
              context.watch<ContadorProvider>().contador.toString(), 
              style: TextStyle(fontSize: 120),
            ),
            ElevatedButton(
              onPressed: (){
              //Aqui vamos a acceder al provider y llamar a la funcion incrementar()
              context.read<ContadorProvider>().incrementar();
              },
              child: Text('Incrementar')
              )
          ],
        ),
      );
  }
}