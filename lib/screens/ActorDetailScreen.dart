import 'package:flutter/material.dart';
import '../helpers/apiServiceActors.dart';
import '../models/actorModel.dart';

class ActorDetailScreen extends StatefulWidget {
  const ActorDetailScreen({Key? key}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  late ApiServiceActors apiService;
  late Future<Actor> futureActor;
  late TextEditingController descriptionController;
  late bool isFavorite;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final actor = ModalRoute.of(context)!.settings.arguments as Actor;

    apiService = ApiServiceActors("http://localhost:3000");
    futureActor = apiService.fetchActorById(actor.id);

    descriptionController = TextEditingController(text: ""); // Se cargará con datos del API
    isFavorite = false; // Valor inicial, se actualizará después
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Actor")),
      body: FutureBuilder<Actor>(
        future: futureActor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No hay datos disponibles."));
          }

          final actor = snapshot.data!;

          // Cargar datos en los campos una vez obtenidos
          descriptionController.text = actor.department;
          isFavorite = false; // Esto lo podríamos manejar con Provider más adelante

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: actor.profilePath.isNotEmpty
                        ? NetworkImage("https://image.tmdb.org/t/p/w500${actor.profilePath}")
                        : AssetImage("assets/actores/default.jpg") as ImageProvider,
                    radius: 50,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción del Actor',
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Favorito'),
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() {
                      isFavorite = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Guardar cambios y volver a la pantalla anterior
                    Navigator.pop(context, actor);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cambios guardados')),
                    );
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
