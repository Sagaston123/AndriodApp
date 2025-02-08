import 'package:flutter/material.dart';
<<<<<<< schroh
import 'package:flutter_application_base/mocks/estrenos_mock.dart'
    show peliculasEstrenos;
import 'package:flutter_application_base/widgets/widgets.dart';
=======
import 'package:provider/provider.dart';
import '../helpers/estrenosProvider.dart';
import '../widgets/movie_card.dart';
>>>>>>> main

class CustomListScreenEstrenos extends StatefulWidget {
  const CustomListScreenEstrenos({super.key});

  @override
  State<CustomListScreenEstrenos> createState() => _CustomListScreenEstrenosState();
}

<<<<<<< schroh
class _CustomListScreenState extends State<CustomListScreenEstrenos> {
  List _auxiliarElements = []; // lista para filtrar resultados
  String _searchQuery = ''; // texto de busqueda
  bool _searchActive = false; // estado de la barra de busqueda

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode =
      FocusNode(); // para manejar el foco en la barra de busqueda
=======
class _CustomListScreenEstrenosState extends State<CustomListScreenEstrenos> {
  bool _isLoading = true;
>>>>>>> main

  @override
  void initState() {
    super.initState();
<<<<<<< schroh
    _auxiliarElements =
        peliculasEstrenos; // inicializa la lista con todos los estrenos
  }

  @override
  void dispose() {
    // limpia los controladores al cerrar la pantalla
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
=======
    _loadData();
>>>>>>> main
  }

  Future<void> _loadData() async {
    final estrenosProvider = Provider.of<EstrenosProvider>(context, listen: false);
    await estrenosProvider.cargarEstrenos();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final estrenosProvider = Provider.of<EstrenosProvider>(context);

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: estrenosProvider.estrenos.length,
              itemBuilder: (context, index) {
                final movie = estrenosProvider.estrenos[index];
                return MovieCard(
                  poster: movie.posterPath,
                  title: movie.title,
                  overview: movie.overview, // Pasamos el overview en lugar de genreIds
                  rating: movie.voteAverage,
                  id: movie.id,
                  isFavorite: estrenosProvider.favoritos.contains(movie.id),
                  onFavoriteToggle: () {
                    estrenosProvider.toggleFavorito(movie.id);
                  },
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'estrenos_list_item',
                      arguments: {
                        'poster': movie.posterPath,
                        'title': movie.title,
                        'overview': movie.overview, // Pasamos el overview
                        'rating': movie.voteAverage,
                        'favorite': estrenosProvider.favoritos.contains(movie.id),
                        'id': movie.id,
                      },
<<<<<<< schroh
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // limpia el texto de busqueda
                      _searchController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _updateSearch('');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      // cierra la barra de busqueda
                      setState(() {
                        _searchActive = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // vuelve a la pantalla anterior
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _searchActive =
                            !_searchActive; // activa la barra de busqueda
                      });
                      _focusNode.requestFocus();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
=======
                    );
                  },
                );
              },
>>>>>>> main
            ),
    );
  }
}