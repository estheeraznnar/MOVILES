import 'package:flutter/material.dart';
import 'package:gestor_de_estados/providers/contador_provider.dart';
import 'package:provider/provider.dart';

class Pagina3 extends StatelessWidget {
  const Pagina3({super.key});

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
              context.read<ContadorProvider>().decrementar();
              },
              child: Text('Decrementar')
              )
          ],
        ),
      );
  }
}