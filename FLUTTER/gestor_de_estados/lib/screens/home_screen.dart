import 'package:flutter/material.dart';
import 'package:gestor_de_estados/pages/page1.dart';
import 'package:gestor_de_estados/pages/page2.dart';
import 'package:gestor_de_estados/pages/page3.dart';
import 'package:gestor_de_estados/providers/contador_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    List<Widget> _pagina = [ Pagina1(), Pagina2(), Pagina3()];
    int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider App'), 
        actions: [
          TextButton(
            onPressed: null, 
            child: Text(
              context.watch<ContadorProvider>().contador.toString(),
              style: TextStyle(color: Colors.white),
            )
          )
        ],
      ), 
      body: _pagina[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                label: 'Pagina 1'
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), 
                label: 'Pagina 2'
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), 
                label: 'Pagina 3'
                )
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        ),
    );
  }
}