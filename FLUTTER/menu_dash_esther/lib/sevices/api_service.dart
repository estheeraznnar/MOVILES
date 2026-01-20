import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dogs_response.dart';

class ApiService {
  static const String baseUrl = 'https://dog.ceo/api/breed';

  Future<DogsResponse?> getPerrosPorRaza(String breed) async {
    try {
      final url = '$baseUrl/$breed/images';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return DogsResponse.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener datos: $e');
      return null;
    }
  }
}
