import 'package:flutter/material.dart';
import 'package:contador_baloncesto_esther/providers/marcador_provider.dart';
import 'package:provider/provider.dart';

class MarcadorPage extends StatelessWidget {
  const MarcadorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcador de Baloncesto'),
        backgroundColor: const Color.fromARGB(255, 19, 175, 99),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Sección Local
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Local',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botón -1
                      _buildBotonCuadrado(
                        context,
                        '-1',
                        () {
                          context.read<MarcadorProvider>().restarPuntosLocal();
                        },
                      ),
                      
                      SizedBox(width: 20),
                      
                      // Marcador
                      Text(
                        context.watch<MarcadorProvider>().puntosLocal.toString(),
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(width: 20),
                      
                      // Botones +1 y +2
                      Column(
                        children: [
                          _buildBotonCuadrado(
                            context,
                            '+1',
                            () {
                              context.read<MarcadorProvider>().sumarPuntosLocal(1);
                            },
                          ),
                          SizedBox(height: 10),
                          _buildBotonCuadrado(
                            context,
                            '+2',
                            () {
                              context.read<MarcadorProvider>().sumarPuntosLocal(2);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Sección Central con Pelota y Botones
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón Reiniciar (icono refresh)
                _buildBotonIcono(
                  context,
                  Icons.refresh,
                  () {
                    context.read<MarcadorProvider>().reiniciarMarcador();
                  },
                ),
                
                SizedBox(width: 20),
                
                // Pelota de baloncesto (IMAGEN LOCAL)
                Container(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    'assets/images/balon.png',
                    fit: BoxFit.contain,
                  ),
                ),
                
                SizedBox(width: 20),
                
                // Botón Cambiar pantalla (icono arrow)
                _buildBotonIcono(
                  context,
                  Icons.arrow_forward,
                  () {
                    // Este botón se puede conectar al FloatingActionButton del home_screen
                  },
                ),
              ],
            ),
          ),
          
          // Sección Visitante
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botón -1
                      _buildBotonCuadrado(
                        context,
                        '-1',
                        () {
                          context.read<MarcadorProvider>().restarPuntosVisitante();
                        },
                      ),
                      
                      SizedBox(width: 20),
                      
                      // Marcador
                      Text(
                        context.watch<MarcadorProvider>().puntosVisitante.toString(),
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(width: 20),
                      
                      // Botones +1 y +2
                      Column(
                        children: [
                          _buildBotonCuadrado(
                            context,
                            '+1',
                            () {
                              context.read<MarcadorProvider>().sumarPuntosVisitante(1);
                            },
                          ),
                          SizedBox(height: 10),
                          _buildBotonCuadrado(
                            context,
                            '+2',
                            () {
                              context.read<MarcadorProvider>().sumarPuntosVisitante(2);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Visitante',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonCuadrado(BuildContext context, String texto, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        minimumSize: Size(60, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBotonIcono(BuildContext context, IconData icono, VoidCallback onPressed) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icono, size: 30),
        color: Colors.black,
      ),
    );
  }
}
