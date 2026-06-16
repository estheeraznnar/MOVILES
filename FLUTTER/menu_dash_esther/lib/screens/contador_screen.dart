import 'package:flutter/material.dart';
import 'package:menu_dash/pages/marcador_page.dart';
import 'package:menu_dash/pages/resultado_page.dart';

//Guarda qué pestaña está activa en _currentIndex, y cada setState() hace que cambie la página visible. 
//StatefulWidget se usa justamente cuando la UI depende de un estado que cambia.
//muestra MarcadorPage y ResultadoPage
// Pantalla contenedora que alterna entre MarcadorPage y ResultadoPage
// Usa BottomNavigationBar y estado local con _currentIndex

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({Key? key}) : super(key: key);

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  List<Widget> _paginas = [MarcadorPage(), ResultadoPage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Marcador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Resultado',
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //cambia entre 0 y 1  (Marcador y resultado)
            _currentIndex = _currentIndex == 0 ? 1 : 0;
          });
        },
        child: Icon(Icons.swap_horiz),
        backgroundColor:const Color.fromARGB(255, 19, 175, 99),
      ),
    );
  }
}
