import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/actorModel.dart';

class ApiServiceActors {
  final String baseUrl;

  ApiServiceActors(this.baseUrl);

  Future<List<Actor>> fetchActors() async {
    final url = Uri.parse("$baseUrl/app/people");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse['data']['results'];
        return results.map((actor) => Actor.fromJson(actor)).toList();
      } else {
        print("Error en la API (Código ${response.statusCode})");
        return []; //Devuelve lista vacia para que no haya errores
      }
    } catch (e) {
      print("Error de conexión con la API: $e");
      return []; //En caso de q no haya internet o falle la api
    }
  }
}
