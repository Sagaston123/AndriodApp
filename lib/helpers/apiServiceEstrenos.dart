import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/estrenosModel.dart';

class ApiServiceEstrenos {
  final String baseUrl;

  ApiServiceEstrenos(this.baseUrl);

  Future<Welcome> fetchEstrenos() async {
    final url = Uri.parse("$baseUrl/app/upcoming");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Welcome.fromJson(jsonResponse);
      } else {
        throw Exception('Error al cargar los estrenos');
      }
    } catch (e) {
      print("Error de conexión con la API: $e");
      throw Exception('Error de conexión con la API');
    }
  }
}