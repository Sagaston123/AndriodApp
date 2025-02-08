import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../helpers/movie_provider.dart';

class CustomListMoviesScreen extends StatefulWidget {
  const CustomListMoviesScreen({super.key});

  @override
  State<CustomListMoviesScreen> createState() => _CustomListMoviesScreenState();
}

class _CustomListMoviesScreenState extends State<CustomListMoviesScreen> {
  List<Movie> filteredMovies = [];
  String searchQuery = '';
  bool isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.loadMovies().then((_) {
      // Agrega .then()
      setState(() {
        filteredMovies = movieProvider.movies;
      });
    });
  }

  void _filterMovies(String query) {
    setState(() {
      searchQuery = query;
      filteredMovies = Provider.of<MovieProvider>(context, listen: false)
          .movies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        actions: [
          IconButton(
            icon: Icon(isSearchActive ? Icons.close : Icons.search),
            onPressed: () {
              setState(() => isSearchActive = !isSearchActive);
              if (!isSearchActive) searchController.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearchActive)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _filterMovies,
                decoration: InputDecoration(
                  hintText: 'Buscar película...',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return ListTile(
                  leading: Image.network(movie.getPosterUrl(), width: 50),
                  title: Text(movie.title),
                  subtitle: Text(movie.category),
                  trailing: IconButton(
                    icon: Icon(
                      movieProvider.isFavorite(movie.id)
                          ? Icons.star
                          : Icons.star_border,
                      color: movieProvider.isFavorite(movie.id)
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                    onPressed: () => movieProvider.toggleFavorite(movie.id),
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    'custom_list_movies_item',
                    arguments: movie,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
