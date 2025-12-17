import 'package:contador/screens/counter_functions_screen.dart';
//import 'package:contador/screens/counter_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, //Cabia el estilo de la app en false pone los botones redondos
                            // y lo de arriba de color y 
                            //false sin lo de arriba y los botones en cuadrado
        colorSchemeSeed: const Color.fromARGB(255, 201, 241, 233)
      ),
      home: CounterFunctionsScreen()
    );
  }
}
