import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/actor_provider.dart';
import '../widgets/actor_card.dart';

class ActoresListScreen extends StatelessWidget {
  const ActoresListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Actores')),
      body: Consumer<ActorProvider>(  //en vez de provider para que solo el body se actualice
        builder: (context, actorProvider, child) {
          if (actorProvider.actores.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
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
                    arguments: actor.id, //Solo el id para que no tarde mucho
                  );
                },
                onFavoriteToggle: () {
                  actorProvider.toggleFavorite(actor.id);
                },
                popularity: actor.popularity, //Solo al popularidad
              );
            },
          );
        },
      ),
    );
  }
}
