import 'package:flutter/material.dart';
import '../helpers/apiServiceActors.dart';
import '../models/actorModel.dart';
import '../widgets/actor_card.dart';

class ActoresListScreen extends StatefulWidget {
  const ActoresListScreen({super.key});

  @override
  State<ActoresListScreen> createState() => _ActoresListScreenState();
}

class _ActoresListScreenState extends State<ActoresListScreen> {
  late ApiServiceActors apiService;
  late Future<List<Actor>> futureActors;

  @override
  void initState() {
    super.initState();
    apiService = ApiServiceActors("http://localhost:3000"); // Conectar con tu backend en Node.js
    futureActors = apiService.fetchActors(); // Llamamos a la API al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actores'),
      ),
      body: FutureBuilder<List<Actor>>(
        future: futureActors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar actores'));
          } else {
            List<Actor> actors = snapshot.data!;

            return ListView.builder(
              itemCount: actors.length,
              itemBuilder: (context, index) {
                final actor = actors[index];

                return ActorCard(
                  actor: actor,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'details',
                      arguments: actor, // Pasamos el objeto Actor directamente
                    );
                  },
                  onFavoriteToggle: () {
                    setState(() {
                      // Acá podríamos manejar favoritos con `SharedPreferences` si queremos
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
