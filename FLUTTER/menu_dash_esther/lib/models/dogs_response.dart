// Modelo de datos para la respuesta de la API
// Equivalente a DogsResponse.kt
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
