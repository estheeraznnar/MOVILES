import 'package:flutter/material.dart';
import 'package:menu_dash/sevices/api_service.dart';
import '../models/dogs_response.dart';
import '../widgets/dog_card.dart';

// Pantalla que busca imágenes de perros por raza
// Gestiona entrada del usuario, carga, errores y resultados

class RazasApiScreen extends StatefulWidget {
  const RazasApiScreen({Key? key}) : super(key: key);

  @override
  State<RazasApiScreen> createState() => _RazasApiScreenState();
}

class _RazasApiScreenState extends State<RazasApiScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<String> _images = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchBreed(String query) async {
    if (query.isEmpty) {
      setState(() {
        _images = [];
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final response = await _apiService.getPerrosPorRaza(query.toLowerCase());

    setState(() {
      _isLoading = false;
      if (response != null && response.status == 'success') {
        _images = response.images;
        _errorMessage = '';
      } else {
        _images = [];
        _errorMessage = 'No se encontró la raza "$query". Intenta con: hound, husky, beagle, etc.';
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Razas Esther'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Buscar raza de perro...',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _images = [];
                        _errorMessage = '';
                      });
                    },
                  ),
              ],
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                _searchBreed(value);
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(fontSize: 16, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : _images.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.pets, size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'Escribe una raza de perro para buscar',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Ejemplos: hound, husky, beagle, poodle',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return DogCard(imageUrl: _images[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
