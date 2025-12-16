import 'package:flutter/material.dart';

class TextFormPersonalizado extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;

  const TextFormPersonalizado({
    super.key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.icon, 
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //initialValue:'Esther A', //texto por defecto
      autofocus: true, //indica donde tiene que ir
      textCapitalization: TextCapitalization.words, //Pne la primera letra de la palabra en may al poner un espacio
      onChanged: (value) {
        print(value);  //tiene control sobre lo que se va escribiendo
      },
      validator: (value) {
        return value!.length < 5 ? 'Minimo 5 caracteres' : null ;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction, //Lo necesito para poder usar el validaror
      decoration: InputDecoration(  //un place holder
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText, //Pone algo encima
        helperText: helperText,
        //counterText: '3 caracteres',
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        //prefixIcon: Icon(Icons.verified_user_outlined)
        icon: icon != null ? Icon(icon): null, //el border respeta el espacio del icono
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}