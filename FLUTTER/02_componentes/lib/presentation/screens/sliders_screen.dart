import 'package:flutter/material.dart';

class SlidersScreen extends StatefulWidget {
  const SlidersScreen({super.key});

  @override
  State<SlidersScreen> createState() => _SlidersScreenState();
}

class _SlidersScreenState extends State<SlidersScreen> {
  double _sliderValue = 30;
  bool _checkValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sliders & Chekes'),),
      body: Column(
        children: [
          Slider.adaptive(
            activeColor: Theme.of(context).primaryColor,
            //divisions: 10,
            min: 0,
            max: 500,
            value: _sliderValue, 
            onChanged: _checkValue ? (value){
              setState(() {
                _sliderValue = value;
                print(value);
              });
            }:null
          ),
          
          /*Checkbox.adaptive(
            value: _checkValue,
            onChanged: ( value ){
              setState(() {
                _checkValue = value ?? true;
              });
            }
          ),

          CheckboxListTile( //Deja marcar en toda la linea y se cambiara no hace falta que sea solo en el cuadrado
            title: Text('Habilitar Slider'),
            value: _checkValue,
            onChanged: ( value ){
              setState(() {
                _checkValue = value ?? true;
              });
            }
          ),

          Switch(
            value: _checkValue,
            onChanged: ( value ){
              setState(() {
                _checkValue = value!;
              });
            }
          ),*/

          SwitchListTile(
            activeThumbColor: const Color.fromARGB(255, 138, 187, 140),
            inactiveThumbColor: Colors.redAccent,
            tileColor: const Color.fromARGB(255, 218, 216, 216),
            subtitle: Text('Habilitar el slider para agrandar la inagen'),
            title: Text('Habilitar Slider'),
            value: _checkValue,
            onChanged: ( value ){
              setState(() {
                _checkValue = value!;
              });
            }
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Image(
                image: NetworkImage('https://cdn.pixabay.com/photo/2020/07/06/17/51/batman-5377804_1280.png'),
                fit: BoxFit.contain,
                width: _sliderValue,
              ),
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}