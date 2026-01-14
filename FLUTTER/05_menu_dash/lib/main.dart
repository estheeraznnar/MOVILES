import 'package:flutter/material.dart';
import 'package:menu_dash/screens/apijson_screen.dart';
import 'package:menu_dash/screens/menu_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MenuScreen(),
        'api1' : (context) => ApiJsonPlaceUsersScreen(), 
      },
    );
  }
}