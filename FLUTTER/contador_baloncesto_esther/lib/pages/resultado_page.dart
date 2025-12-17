import 'package:flutter/material.dart';
import 'package:contador_baloncesto_esther/providers/marcador_provider.dart';
import 'package:provider/provider.dart';

class ResultadoPage extends StatelessWidget {
  const ResultadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        backgroundColor: const Color.fromARGB(255, 19, 175, 99),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Local - Visitante',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40),
            Text(
              '${context.watch<MarcadorProvider>().puntosLocal} - ${context.watch<MarcadorProvider>().puntosVisitante}',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            Text(
              context.watch<MarcadorProvider>().obtenerResultado(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
