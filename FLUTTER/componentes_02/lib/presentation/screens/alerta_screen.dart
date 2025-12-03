import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertaScreen extends StatelessWidget {
  const AlertaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Funcion para mostrar la alerta
    void mostrarAlertaAndroir() {
      showDialog(
        barrierDismissible:
            false, //Al mostrar la alerta si se pulsa fuera no se va
        context: context,
        builder: (context) => AlertDialog(
          //funcion a la que se le pasa el contexto, crea el wigget
          //Cupertion la forma de iphone y alert dialog la forma de androir
          title: Text('titulo de la alerta'), //Titulo
          content: Column(
            //contenido con wigget(texto, logo)
            mainAxisSize: MainAxisSize
                .min, //Para que la alerta ocupe solo lo que necesito al meterla
            //en una columna por defecto cocupa todo por eso lo ponemos
            children: [
              Text('Esto es el contenido de la alerta'),
              SizedBox(
                height: 10,
              ), //Deja un espacio entre el texto y la imagen es como el <br>
              FlutterLogo(
                size: 100, //Tamaño de la imagen
                style: FlutterLogoStyle.stacked, //Pone texto debajo
                textColor: Colors.blueAccent, //Pone el corror en el texto
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Aceptar',
                style: TextStyle(color: const Color.fromARGB(255, 2, 86, 46)),
              ),
            ),
          ],
        ),
      );
    }

    void mostrarAlertaIphone() {
      showDialog(
        barrierDismissible:
            false, //Al mostrar la alerta si se pulsa fuera no se va
        context: context,
        builder: (context) => CupertinoAlertDialog(
          //funcion a la que se le pasa el contexto, crea el wigget
          //Cupertion la forma de iphone y alert dialog la forma de androir
          title: Text('titulo de la alerta'), //Titulo
          content: Column(
            //contenido con wigget(texto, logo)
            mainAxisSize: MainAxisSize.min, //Para que la alerta ocupe solo lo que necesito al meterla
            //en una columna por defecto cocupa todo por eso lo ponemos
            children: [
              Text('Esto es el contenido de la alerta'),
              SizedBox(
                height: 10,
              ), //Deja un espacio entre el texto y la imagen es como el <br>
              FlutterLogo(
                size: 100, //Tamaño de la imagen
                style: FlutterLogoStyle.stacked, //Pone texto debajo
                textColor: Colors.blueAccent, //Pone el corror en el texto
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Aceptar',
                style: TextStyle(color: const Color.fromARGB(255, 2, 86, 46)),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Alertas')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //si es iphone coge su metodo y sino coge el de android
            Platform.isAndroid ? mostrarAlertaAndroir() : mostrarAlertaIphone();
          },
          child: Text('Mostrar Alerta'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
