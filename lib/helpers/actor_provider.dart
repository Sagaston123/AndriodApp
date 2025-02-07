import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/apiServiceActors.dart';
import '../models/actorModel.dart';

class ActorProvider extends ChangeNotifier {
  List<Actor> actores = [];
  Set<int> favoritos = {}; 
  final ApiServiceActors apiService = ApiServiceActors("http://localhost:3000");

  ActorProvider() {
    cargarActores();
  }

  // Carga la lista de actores desde la API y guarda los favoritos
  Future<void> cargarActores() async {
    try {
      actores = await apiService.fetchActors();
      await _loadFavorites(); // Cargamos favoritos después de obtener los actores
      notifyListeners();
    } catch (e) {
      print("Error al cargar actores: $e");
    }
  }

  // Carga los favoritos desde SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoritos = prefs.getStringList('favoritos')?.map(int.parse).toSet() ?? {};
  }

  // Agrega o quita un actor de favoritos y lo guarda en SharedPreferences
  Future<void> toggleFavorite(int actorId) async {
    final prefs = await SharedPreferences.getInstance();

    if (favoritos.contains(actorId)) {
      favoritos.remove(actorId);
    } else {
      favoritos.add(actorId);
    }

    await prefs.setStringList('favoritos', favoritos.map((id) => id.toString()).toList());
    notifyListeners(); // Notificamos a los widgets que usan Provider
  }

  // Devuelve un actor por ID sin volver a llamar a la API
  Actor? getActorById(int id) {
    return actores.firstWhere(
      (actor) => actor.id == id,
      orElse: () => Actor(id: 0, name: "No encontrado", profilePath: "", department: "N/A", popularity: 0.0, knownFor: []),
    );
  }
}
