import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget{
  const CounterScreen
  

}


class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Counter Screen'),
        centerTitle: true,
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('10', style: TextStyle(fontSize: 160, fontWeight: FontWeight.w100),),
              Text('Clicks', style: TextStyle(fontSize: 25),),
            ],
        ),
        ), 
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.add),
          onPressed: (){

          }
          ),
      );
  }
}