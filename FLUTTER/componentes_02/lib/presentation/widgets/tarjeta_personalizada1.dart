import 'package:flutter/material.dart';

class TarjetaPersonalizada1 extends StatelessWidget {
  const TarjetaPersonalizada1({
    super.key,
    });


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card( //Elemento
      child: Column( //dentro voy poniendo elementos
        children: [ 
          ListTile( //Primero esto
            leading: Icon(Icons.photo_album_outlined, color: colors.primary,),
            title: Text('Soy un titulo'),
            subtitle: Text('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose.'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10), //Pone el pading que quiero
            child: Row( //despues creo la row para poner los botones
              mainAxisAlignment: MainAxisAlignment.end, //Le pongo donde quiero que se ponga
              children: [
                TextButton(onPressed: (){}, child: Text('Cancel'), style: TextButton.styleFrom(foregroundColor: colors.error),), //Lo pone en color rojo
                TextButton(onPressed: (){}, child: Text('Ok')),
              ],
            ),
          )
        ],
      ),
    );
  }
}