import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/estrenosProvider.dart';
import '../widgets/movie_card.dart';

class CustomListScreenEstrenos extends StatefulWidget {
  const CustomListScreenEstrenos({super.key});

  @override
  State<CustomListScreenEstrenos> createState() => _CustomListScreenEstrenosState();
}

class _CustomListScreenEstrenosState extends State<CustomListScreenEstrenos> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
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
                    );
                  },
                );
              },
            ),
    );
  }
}