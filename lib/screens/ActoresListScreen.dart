import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/actor_provider.dart';
import '../widgets/actor_card.dart';

class ActoresListScreen extends StatelessWidget {
  const ActoresListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actorProvider = Provider.of<ActorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actores'),
      ),
      body: actorProvider.actores.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: actorProvider.actores.length,
              itemBuilder: (context, index) {
                final actor = actorProvider.actores[index];

                return ActorCard(
                  actor: actor,
                  isFavorite: actorProvider.favoritos.contains(actor.id),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'details',
                      arguments: actor.id,
                    );
                  },
                  onFavoriteToggle: () {
                    actorProvider.toggleFavorite(actor.id);
                  },
                  popularity: actor.popularity, // ✅ Agregado para mostrar la popularidad
                );
              },
            ),
    );
  }
}
