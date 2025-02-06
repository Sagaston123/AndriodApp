import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/apiServiceActors.dart';
import '../models/actorModel.dart';

class ActorProvider extends ChangeNotifier {
  List<Actor> actores = [];
  Set<int> favoritos = {}; // IDs de los actores favoritos
  final ApiServiceActors apiService = ApiServiceActors("http://localhost:3000");

  ActorProvider() {
    cargarActores();
    _loadFavorites();
  }

  Future<void> cargarActores() async {
    try {
      actores = await apiService.fetchActors();
      notifyListeners();
    } catch (e) {
      print("Error al cargar actores: $e");
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoritos = prefs.getStringList('favoritos')?.map(int.parse).toSet() ?? {};
    notifyListeners();
  }

  Future<void> toggleFavorite(int actorId) async {
    final prefs = await SharedPreferences.getInstance();
    if (favoritos.contains(actorId)) {
      favoritos.remove(actorId);
    } else {
      favoritos.add(actorId);
    }
    prefs.setStringList('favoritos', favoritos.map((id) => id.toString()).toList());
    notifyListeners();
  }
}
