import 'package:flutter/material.dart';

class TarjetaPerosnalizada2 extends StatelessWidget {

  final String urlImagen;
  final String? texto;

  const TarjetaPerosnalizada2({
    super.key, 
    required this.urlImagen,
    this.texto //Si llega nulo no le pone nada
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, //Para que la imagen no se salga de la tarjeta
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)), //Lo redondea a lo que quieras
      elevation: 10,
      child: Column(
        children: [
          FadeInImage( //Es para poner algo que se muestremientras carga la imagen
          image: NetworkImage(urlImagen),
            //image: NetworkImage('https://thumbs.dreamstime.com/b/paisaje-id%C3%ADlico-del-verano-con-el-lago-claro-de-la-monta%C3%B1a-en-las-monta%C3%B1as-45054687.jpg'), //Pone una imagen de internet 
            fit: BoxFit.cover, 
            placeholder: AssetImage('assets/jar-loading.gif'), //le meto el gif que tengo en la carpeta de assets que me he creado a nivel general
            width: double.infinity,
            height: 230,
            //fadeInDuration: Duration(microseconds: 400),
          ),
          if(texto != null) //Si no tiene texto muestra el continer ya que se asegura de que no sea nulo
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: Text(texto!), //La exclamacion es que tiene texto si o si aunque no se le meta
          )
        ],
      ),
    );
  }
}