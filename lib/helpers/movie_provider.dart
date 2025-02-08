import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/apiServiceMovies.dart'; // Importamos el ApiServiceMovies
import '../models/movie.dart'; // Importamos el modelo Movie

class MovieProvider with ChangeNotifier {
  List<Movie> movies = []; // Lista de películas
  Set<int> favorites = {}; // Conjunto de IDs de películas favoritas
  final ApiServiceMovies apiService = ApiServiceMovies(
      "http://localhost:3000"); // Instancia del ApiServiceMovies

  MovieProvider() {
    loadMovies(); // Cargar películas al inicializar
  }

  // Carga la lista de películas desde la API y guarda los favoritos
  Future<void> loadMovies() async {
    try {
      final data = await apiService.fetchPopularMovies();
      movies = data;
      await _loadFavorites(); // Cargar favoritos después de obtener las películas
      notifyListeners();
    } catch (e) {
      print("Error al cargar películas: $e");
    }
  }

  // Carga los favoritos desde SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favorites =
        prefs.getStringList('favorite_movies')?.map(int.parse).toSet() ?? {};
  }

  // Agrega o quita una película de favoritos y lo guarda en SharedPreferences
  Future<void> toggleFavorite(int movieId) async {
    final prefs = await SharedPreferences.getInstance();

    if (favorites.contains(movieId)) {
      favorites.remove(movieId);
    } else {
      favorites.add(movieId);
    }

    await prefs.setStringList(
      'favorite_movies',
      favorites.map((id) => id.toString()).toList(),
    );
    notifyListeners(); // Notificamos a los widgets que usan Provider
  }

  // Verificar si una película es favorita
  bool isFavorite(int movieId) {
    return favorites.contains(movieId);
  }

  // Devuelve una película por ID sin volver a llamar a la API
  Movie? getMovieById(int id) {
    return movies.firstWhere(
      (movie) => movie.id == id,
      orElse: () => Movie(
        id: 0,
        title: "No encontrada",
        category: "Sin género",
        releaseDate: "",
        posterPath: "",
      ),
    );
  }
}
