import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Tarjeta reutilizable para mostrar una imagen remota de perro
// Incluye placeholder mientras carga y widget de error si falla

class DogCard extends StatelessWidget {
  final String imageUrl;

  const DogCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          height: 320,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
