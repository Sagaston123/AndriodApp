class Movie {
  final int id;
  final String title;
  final String category;
  final String releaseDate;
  final String posterPath;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.category,
    required this.releaseDate,
    required this.posterPath,
    this.isFavorite = false,
  });

  // Método para crear una instancia de Movie desde un JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sin título',
      category: (json['genre_ids'] as List?)?.isNotEmpty == true
          ? json['genre_ids'][0].toString()
          : 'Sin género',
      releaseDate:
          json['release_date'] ?? 'Fecha desconocida', // ⚠️ release_date
      posterPath: json['poster_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre_ids': [int.tryParse(category) ?? 0], // Ajusta según tu lógica
      'release_date': releaseDate, // ⚠️ release_date
      'poster_path': posterPath,
      'isFavorite': isFavorite,
    };
  }

  // Método para obtener la URL completa del póster
  String getPosterUrl() {
    return "https://image.tmdb.org/t/p/w500$posterPath";
  }
}
