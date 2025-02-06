import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/actorModel.dart';

class ApiServiceActors {
  final String baseUrl;

  ApiServiceActors(this.baseUrl);

  Future<List<Actor>> fetchActors() async {
    final url = Uri.parse("$baseUrl/app/people");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['data']['results'];
      return results.map((actor) => Actor.fromJson(actor)).toList();
    } else {
      throw Exception("Error al cargar los actores: ${response.statusCode}");
    }
  }

  Future<Actor> fetchActorById(int id) async {
  final url = Uri.parse("$baseUrl/app/people/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return Actor.fromJson(jsonResponse['data']);
  } else {
    throw Exception("Error al cargar el actor: ${response.statusCode}");
  }
}

}
