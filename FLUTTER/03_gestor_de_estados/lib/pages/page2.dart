import 'package:flutter/material.dart';
import 'package:gestor_de_estados/providers/contador_provider.dart';
import 'package:provider/provider.dart';

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.watch<ContadorProvider>().contador.toString(),
          style: TextStyle(fontSize: 160),
        ),
      ),
    );
  }
}