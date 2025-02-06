import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/actor_provider.dart';
import '../models/actorModel.dart';

class ActorDetailScreen extends StatefulWidget {
  const ActorDetailScreen({Key? key}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  late TextEditingController descriptionController;
  late Actor actor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actor = ModalRoute.of(context)!.settings.arguments as Actor;

    // Inicializamos la descripción sin sobrescribirla en cada render
    descriptionController = TextEditingController(text: actor.department);
  }

  @override
  Widget build(BuildContext context) {
    final actorProvider = Provider.of<ActorProvider>(context);
    final isFavorite = actorProvider.favoritos.contains(actor.id);

    return Scaffold(
      appBar: AppBar(title: Text("Detalles de ${actor.name}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: actor.profilePath.isNotEmpty
                    ? NetworkImage("https://image.tmdb.org/t/p/w500${actor.profilePath}")
                    : const AssetImage("assets/actores/default.jpg") as ImageProvider,
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            // Campo fijo "Actor"
            Text(
              "Actor",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Descripción (máx 2 líneas)
            TextFormField(
              controller: descriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Descripción del Actor',
              ),
            ),
            const SizedBox(height: 16),
            // Switch de favorito usando Provider
            SwitchListTile(
              title: const Text('Favorito'),
              value: isFavorite,
              onChanged: (value) {
                actorProvider.toggleFavorite(actor.id);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, actor);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cambios guardados')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
