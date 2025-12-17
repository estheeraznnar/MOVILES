import 'package:flutter/material.dart';
import 'package:contador_baloncesto_esther/pages/marcador_page.dart';
import 'package:contador_baloncesto_esther/pages/resultado_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            _currentIndex = _currentIndex == 0 ? 1 : 0;
          });
        },
        child: Icon(Icons.swap_horiz),
        backgroundColor:const Color.fromARGB(255, 19, 175, 99),
      ),
    );
  }
}
