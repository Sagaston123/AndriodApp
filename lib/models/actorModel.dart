class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String department;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.department,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',  // Si no hay imagen, devuelve string vacío
      department: json['known_for_department'],
    );
  }
}
