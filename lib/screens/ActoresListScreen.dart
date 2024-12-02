import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/ActoresMock.dart';
import 'package:flutter_application_base/widgets/widgets.dart';

class ActoresListScreen extends StatefulWidget {
  const ActoresListScreen({Key? key}) : super(key: key);

  @override
  State<ActoresListScreen> createState() => _ActoresListScreenState();
}

class _ActoresListScreenState extends State<ActoresListScreen> {
  List<Map<String, dynamic>> actors = ActoresMock.actors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actores'),
      ),
      body: ListView.builder(
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return ActorCard(
            actor: actor,
            onTap: () async {
              final updatedActor = await Navigator.pushNamed(
                context,
                'details',
                arguments: actor,
              );

              if (updatedActor != null) {
                setState(() {
                  actors[index] = updatedActor as Map<String, dynamic>;
                });
              }
            },
            onFavoriteToggle: () {
              setState(() {
                actor['isFavorite'] = !actor['isFavorite'];
              });
            },
          );
        },
      ),
    );
  }
}
