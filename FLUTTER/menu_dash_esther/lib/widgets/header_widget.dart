import 'package:flutter/material.dart';

// Cabecera visual de la sección Diseños

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 140.0,
      decoration: BoxDecoration(color: Color.fromARGB(255, 58, 58, 58)),
      child: Row(
        children: [
          Text('Diseños', 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 24, 
            fontWeight: FontWeight.bold
          ), 
          ),
        ],
      ),
    );
  }
}