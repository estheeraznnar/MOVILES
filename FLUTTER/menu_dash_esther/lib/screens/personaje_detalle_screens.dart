import 'package:flutter/material.dart';
import 'package:menu_dash/widgets/blur_container.dart';
import 'package:menu_dash/widgets/infotitle_widget.dart';

class PersonajeDetalleScreens extends StatefulWidget {
  const PersonajeDetalleScreens({
    Key? key,
    required this.color,
    required this.imagen,
    required this.nombre,
  }) : super(key: key);

  final Color color; //lo q llega aqui es lo que se manda desde el otro lado
  final String imagen;
  final String nombre;

  @override
  State<PersonajeDetalleScreens> createState() =>
      _PersonajeDetalleScreensState();
}

class _PersonajeDetalleScreensState extends State<PersonajeDetalleScreens> {
  double _alturaPantalla = 0;

  @override
  Widget build(BuildContext context) {
    _alturaPantalla = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //pone el color de fondo
            begin: AlignmentGeometry.topCenter, //lo pone de arriba abajp
            end: AlignmentGeometry.bottomCenter,
            colors: [widget.color, Color.fromARGB(255, 16, 16, 16)],
          ), //coge el color de la imagen a la que clico
        ),
        child: Column(
          crossAxisAlignment: .start, //con poner . intulle el que es
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: _alturaPantalla * 0.6,
                    child: Hero(
                      tag: widget.imagen,
                      child: Image.asset('assets/${widget.imagen}.png'),
                    ), //hay que poner la ruta porque sino no funcionara y dara error
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 12,
                  child: BlurContainer(
                    child: Container(
                      width: 160,
                      height: 50,
                      alignment: .center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: .circular(10),
                      ),
                      child: Text(
                        widget.nombre,
                        style: TextStyle(
                          fontWeight: .bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Personaje: ${widget.nombre}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: .bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "One Piece",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  InfoTitleWidget(titulo: "Eiichiró Oda", subTitulo: "Creador"),
                  InfoTitleWidget(titulo: "Japón", subTitulo: "País"),
                ],
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 50,
                alignment: .center,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.6),
                  borderRadius: .circular(10),
                ),
                child: Text(
                  "Volver",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
