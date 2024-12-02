import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  final Map<String, dynamic> actor;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ActorCard({
    Key? key,
    required this.actor,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(actor['image'] ?? 'assets/images/default.jpg'),
          radius: 50,
        ),
        title: Text(actor['name'] ?? 'Sin Nombre'),
        subtitle: Text('${actor['category']}, ${actor['experience']} años'),
        trailing: IconButton(
          icon: Icon(
            actor['isFavorite'] ? Icons.star : Icons.star_border,
            color: actor['isFavorite'] ? Colors.amber : null,
          ),
          onPressed: onFavoriteToggle,
        ),
        onTap: onTap,
      ),
    );
  }
}
