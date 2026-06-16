// Modelo de datos para la respuesta de la API
// Equivalente a DogsResponse.kt

// Servicio encargado de llamar a la API de perros
// Construye la URL, hace la petición y transforma el JSON en modelo
class DogsResponse {
  final String status;
  final List<String> images;

  DogsResponse({
    required this.status,
    required this.images,
  });

  factory DogsResponse.fromJson(Map<String, dynamic> json) {
    return DogsResponse(
      status: json['status'] as String,
      images: List<String>.from(json['message'] as List),
    );
  }
}
