import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart'; // Modelo de película

class ApiServiceMovies {
  final String baseUrl;

  ApiServiceMovies(this.baseUrl);

  // Obtener películas populares
  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse("$baseUrl/app/movies/popular");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse[
            'data']; // Asumiendo que la respuesta tiene un campo 'data'

        return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        print("Error en la API (Código ${response.statusCode})");
        return []; // Devuelve lista vacía para que no haya errores
      }
    } catch (e) {
      print("Error de conexión con la API: $e");
      return []; // En caso de que no haya internet o falle la API
    }
  }
}
