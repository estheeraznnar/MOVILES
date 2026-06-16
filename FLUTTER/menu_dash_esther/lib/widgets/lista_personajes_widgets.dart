import 'package:flutter/material.dart';
import 'package:menu_dash/screens/personaje_detalle_screens.dart';

//tiene dos partes la fila superior con miniaturas y los bloques inferiores clicables
//Usa Expanded porque está metido dentro de un Column, y así ocupa el resto del espacio disponible.
//lo usa DiseniosScreens, navefa a PersonajeDetalleScreens y usa Hero para transicion de imagen
// Lista visual de personajes
// Construye miniaturas superiores y bloques clicables inferiores

class ListaPersonajesWidget extends StatefulWidget {
  const ListaPersonajesWidget({super.key});

  @override
  State<ListaPersonajesWidget> createState() => _ListaPersonajesWidgetState();
}

class _ListaPersonajesWidgetState extends State<ListaPersonajesWidget> {

  final tituloStyleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(25),
        children: [
          Text('Personajes', style: tituloStyleText,),
          Row(
            children: [
              _personajeLista('p1','Titulo', 'subtitulo'),
              SizedBox(width: 15,),
              _personajeLista('p2','Titulo', 'subtitulo'),
              SizedBox(width: 15,),
              _personajeLista('p3','Titulo', 'subtitulo'),
            ],
          ),
          Divider(color: Colors.grey, thickness: 1,),
          SizedBox(height: 15,),
          _bloquePersonajes("Brook", const Color.fromARGB(255, 223, 37, 37), "o1"),
          _bloquePersonajes("Luffy", const Color.fromARGB(255, 37, 223, 161), "o2"),
          _bloquePersonajes("Portgas D. Ace", const Color.fromARGB(255, 211, 223, 37), "o3"),
          _bloquePersonajes("Boa Hancock", const Color.fromARGB(255, 65, 37, 223), "o4"),
          _bloquePersonajes("Boa Hancock", const Color.fromARGB(255, 255, 58, 255), "o5"),
          _bloquePersonajes("Roronoa Zero", const Color.fromARGB(255, 0, 224, 253), "o6"),
        ],
      ),
    );
  }

  Widget _personajeLista(String imagen, String titulo, String subtitulo) {

    double anchoPantalla = MediaQuery.of(context).size.width - 50;
    return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/$imagen.jpg",
                    width: anchoPantalla * 0.3,
                    height: 110,
                    fit: BoxFit.cover,
                    ),
                ),
                SizedBox(height: 15,),
                RichText(
                  text: TextSpan(
                    text: titulo,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    children: [
                      TextSpan(
                    text: subtitulo,
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                    ]
                  ),
                  
                  )
              ],
            );
  }

  Widget _bloquePersonajes(String nombre, Color color, String imagen){
    return GestureDetector( //Para que el container sea clicable
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> PersonajeDetalleScreens(color: color, imagen: imagen, nombre: nombre,)) //Le voy metiendo los elementos del container a la pantalla de detalle
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(66, 43, 43, 43),
          borderRadius: BorderRadius.circular(10)
        ),
        height: 65,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: color, //coge el color que he definido arriba
                        blurRadius: 10, //blurRadius es el difuninado
                        offset: Offset(0, 5)//ofset es el desplazamiento 
                      ) ]
                  ),
                  child: Hero( //El hero lleva la imagen desde la posicion inicial de 
                              //una pantalla hasta la posicion donde le corresponde en la siguiente pantalla
                    tag: imagen , //Tiene que ser un nombre unico y no se puede repetir
                    child: Image.asset("assets/$imagen.png")
                  ),
                ),
                SizedBox(width: 15,),
                Text(nombre, style: TextStyle(color: Colors.white70, fontSize: 16),),
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded), color: Colors.white70,)
          ],
        ),
      ),
    );
  }
}