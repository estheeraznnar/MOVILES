import 'package:componentes_02/presentation/widgets/text_form_personalizado.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatelessWidget {
   
  const FormularioScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario'),), 
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormPersonalizado(
              labelText: 'Nombre',
              hintText: 'Nombre del usuario',
              icon: Icons.person,
            ),
            SizedBox(height: 20,),
            TextFormPersonalizado(
              labelText: 'Apellido',
              hintText: 'Apellido del usuario',
              icon: Icons.person,
            ),
            SizedBox(height: 20,),
            TextFormPersonalizado(
              labelText: 'Correo',
              hintText: 'Correo del usuario',
              icon: Icons.email_outlined,
            ),
            SizedBox(height: 20,),
            TextFormPersonalizado(
              labelText: 'Password',
              hintText: 'Contraseña',
              icon: Icons.lock,
            ),
          ],
        ),
        
        ),
      ),
    );
    
  }
}

