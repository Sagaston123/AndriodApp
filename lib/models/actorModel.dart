class Movie {
  final int id;
  final String title;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {  //Convierte el json en un objeto Movie
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['original_title'] ?? json['original_name'] ?? "Título no disponible",
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }
}

class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String department;
  final double popularity;
  final List<Movie> knownFor;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.department,
    required this.popularity,
    required this.knownFor,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {   //Convierte el json en un objeto Actor
    return Actor(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Nombre Desconocido",
      profilePath: json['profile_path'] ?? "", 
      department: json['known_for_department'] ?? "No especificado",
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      knownFor: (json['known_for'] as List?)
          ?.map((movie) => Movie.fromJson(movie))
          .toList() ?? [],
    );
  }
}
