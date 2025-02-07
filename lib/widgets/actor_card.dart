import 'package:flutter/material.dart';
import '../models/actorModel.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final double popularity;

  const ActorCard({
    Key? key,
    required this.actor,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.popularity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: actor.profilePath.isNotEmpty
            ? NetworkImage("https://image.tmdb.org/t/p/w500${actor.profilePath}")
            : const AssetImage("assets/actores/default.jpg") as ImageProvider,
        radius: 30,
      ),
      title: Text(actor.name),
      subtitle: Text("Popularidad: ${popularity.toStringAsFixed(2)}"), // ✅ Se muestra la popularidad
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          color: isFavorite ? Colors.yellow : null,
        ),
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
