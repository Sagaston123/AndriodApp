import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/apiServiceEstrenos.dart';
import '../models/estrenosModel.dart';

class EstrenosProvider with ChangeNotifier {
  List<Result> _estrenos = [];
  Set<int> _favoritos = {};
  final ApiServiceEstrenos _apiService = ApiServiceEstrenos("http://localhost:3000");

  List<Result> get estrenos => _estrenos;
  Set<int> get favoritos => _favoritos;

  EstrenosProvider() {
    cargarEstrenos();
  }

  Future<void> cargarEstrenos() async {
    try {
      final response = await _apiService.fetchEstrenos();
      _estrenos = response.data.results;
      await _cargarFavoritos();

      notifyListeners(); // Notificar solo una vez
    } catch (e) {
      print("Error al cargar estrenos: $e");
    }
  }

  Future<void> _cargarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritosGuardados = prefs.getStringList('favoritos') ?? [];
    _favoritos = favoritosGuardados.map((id) => int.parse(id)).toSet();
  }

  Future<void> toggleFavorito(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoritos.contains(id)) {
      _favoritos.remove(id);
    } else {
      _favoritos.add(id);
    }
    await prefs.setStringList('favoritos', _favoritos.map((id) => id.toString()).toList());
    notifyListeners(); // Notificar solo cuando cambien los favoritos
  }
}