import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/actor_provider.dart';
import '../models/actorModel.dart';

class ActorDetailScreen extends StatefulWidget {
  const ActorDetailScreen({Key? key}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  late Actor actor;
  late TextEditingController descriptionController;
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final actorProvider = Provider.of<ActorProvider>(context, listen: false);
    final int actorId = ModalRoute.of(context)!.settings.arguments as int;

    actor = actorProvider.getActorById(actorId) ?? Actor(
      id: actorId,
      name: "Desconocido",
      profilePath: "",
      department: "N/A",
      popularity: 0.0,
      knownFor: [],
    );

    // Inicializar la descripción con lo guardado en SharedPreferences
    descriptionController = TextEditingController();
    _loadDescription();
    
    // Estado de favorito desde el Provider
    isFavorite = actorProvider.favoritos.contains(actor.id);
  }

  // Cargar la descripción desde SharedPreferences
  Future<void> _loadDescription() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      descriptionController.text = prefs.getString('description_${actor.id}') ?? "";
    });
  }

  // Guardar la descripción en SharedPreferences
  Future<void> _saveDescription() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('description_${actor.id}', descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final actorProvider = Provider.of<ActorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Detalles de ${actor.name}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del actor centrada
            Center(
              child: CircleAvatar(
                backgroundImage: actor.profilePath.isNotEmpty
                    ? NetworkImage("https://image.tmdb.org/t/p/w500${actor.profilePath}")
                    : const AssetImage("assets/actores/default.jpg") as ImageProvider,
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),

            // Switch de favorito ahora arriba
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Favorito", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Switch(
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() {
                      isFavorite = value;
                      actorProvider.toggleFavorite(actor.id);
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de películas
            const Text("Películas:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: actor.knownFor.isEmpty
                  ? const Text("No hay películas disponibles.")
                  : ListView.builder(
                      itemCount: actor.knownFor.length,
                      itemBuilder: (context, index) {
                        final movie = actor.knownFor[index];
                        final movieTitle = movie.title.isNotEmpty
                            ? movie.title
                            : movie.id != 0
                                ? "Título no disponible"
                                : "Sin información";

                        return ListTile(
                          title: Text(movieTitle),
                          subtitle: Text("ID: ${movie.id} | Géneros: ${movie.genreIds.join(', ')}"),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),

            // Campo de descripción con máximo 2 líneas
            TextFormField(
              controller: descriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Descripción personal',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Botón de guardar centrado
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveDescription();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cambios guardados')),
                  );
                },
                child: const Text('Guardar'),
              ),
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
