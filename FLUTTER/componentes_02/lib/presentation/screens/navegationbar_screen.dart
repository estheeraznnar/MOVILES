import 'package:flutter/material.dart';

class NavegationBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegation Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _NavegationBarScreen(title: 'Navegation Bar'),
    );
  }
}

class _NavegationBarScreen extends StatefulWidget {
  final String title;

  const _NavegationBarScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<_NavegationBarScreen> createState() => _NavegationBarScreenState();
}

class _NavegationBarScreenState extends State<_NavegationBarScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // NavigationBar Example
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        //backgroundColor: Colors.blue,
        //elevation: 10,
        //surfaceTintColor: Colors.lime,
        //height: 20,
        //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      body: <Widget>[
        Container(
          color: const Color.fromARGB(255, 92, 203, 255),
          alignment: Alignment.center,
          child: const Text('Blue!'),
        ),
        Container(
          color: const Color.fromARGB(255, 134, 255, 160),
          alignment: Alignment.center,
          child: const Text('Green!'),
        ),
        Container(
          color: const Color.fromARGB(255, 255, 174, 201),
          alignment: Alignment.center,
          child: const Text('Pink'),
        ),
        Container(
          color: const Color.fromARGB(255, 179, 151, 255),
          alignment: Alignment.center,
          child: const Text('Purple'),
        ),
      ][currentPageIndex],
    );
  }
}
