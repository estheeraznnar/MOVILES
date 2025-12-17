import 'package:componentes_02/presentation/widgets/tarjeta_perosnalizada2.dart';
import 'package:componentes_02/presentation/widgets/tarjeta_personalizada1.dart';
import 'package:flutter/material.dart';

class TarjetasScreen extends StatelessWidget {
  const TarjetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarjetas'),),
      body: ListView(
        padding: EdgeInsets.all(6),
        children: [
          TarjetaPersonalizada1(), //Lo extraigo como un widget y me lo llevo al archivo que me he creado para que sea mas limpio y mas claro
          SizedBox(height: 10,),
          TarjetaPerosnalizada2(urlImagen: 'https://thumbs.dreamstime.com/b/paisaje-id%C3%ADlico-del-verano-con-el-lago-claro-de-la-monta%C3%B1a-en-las-monta%C3%B1as-45054687.jpg', texto: 'Un paisaje precioso',),
          SizedBox(height: 10,),
          TarjetaPerosnalizada2(urlImagen: 'https://www.espanafascinante.com/media/espanafascinante/images/2024/04/17/20240417115225433403.jpg',),
          SizedBox(height: 10,),
          TarjetaPerosnalizada2(urlImagen: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgeFsqiCZ9dqC9CCNb3vqhLOyWcdU0PV0UtYiVs_PuanxtUaGsDxcL-1nJdA2zTY2tztBPzup8mp4ZejXZkIs0ZioYBVYGxk8E8XLxUhmSJIKYgKWbIMutaH0uDYJfvdnpNJn_gXTyGJJ0/s1600/02273+paisajes01.jpg',),
          SizedBox(height: 10,),
          TarjetaPerosnalizada2(urlImagen: 'https://images.ecestaticos.com/E7kXB94QRcyHbFSBt4e2Q83lQ7s=/0x118:1183x783/1200x900/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2F397%2F325%2Fb2b%2F397325b2b8f7f1e3e503dbb5183e1d65.jpg',),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

