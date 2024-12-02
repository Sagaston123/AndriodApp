import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/movie_mock.dart' show elements;
import 'package:shared_preferences/shared_preferences.dart';

class CustomListMoviesScreen extends StatefulWidget {
  const CustomListMoviesScreen({super.key});

  @override
  State<CustomListMoviesScreen> createState() => _CustomListMoviesScreenState();
}

class _CustomListMoviesScreenState extends State<CustomListMoviesScreen> {
  List<Map<String, dynamic>> filteredMovies = [];
  String searchQuery = '';
  bool isSearchActive = false;

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _initializeMovies() async {
    final prefs = await SharedPreferences.getInstance();
    filteredMovies = elements
        .map((e) => {
              'avatar': e[0],
              'name': e[1],
              'category': e[2],
              'releaseDate': e[3],
              'isFavorite': prefs.getBool('favorite_${e[1]}') ?? false,
            })
        .toList();
    setState(() {});
  }

  void _filterMovies(String? query) {
    setState(() {
      searchQuery = query ?? '';
      if (searchQuery.isEmpty) {
        _initializeMovies();
      } else {
        filteredMovies = elements
            .where((element) =>
                element[1].toLowerCase().contains(searchQuery.toLowerCase()))
            .map((e) => {
                  'avatar': e[0],
                  'name': e[1],
                  'category': e[2],
                  'releaseDate': e[3],
                  'isFavorite': false,
                })
            .toList();
      }
    });
  }

  void _toggleFavorite(int index) async {
    setState(() {
      filteredMovies[index]['isFavorite'] =
          !filteredMovies[index]['isFavorite'];
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${filteredMovies[index]['name']}',
        filteredMovies[index]['isFavorite']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Películas'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: Icon(isSearchActive ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isSearchActive = !isSearchActive;
                });
                if (!isSearchActive) {
                  searchController.clear();
                  _filterMovies('');
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (isSearchActive) _buildSearchBar(),
            _buildMovieList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        focusNode: focusNode,
        onChanged: _filterMovies,
        decoration: InputDecoration(
          hintText: 'Buscar película...',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              _filterMovies('');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildMovieList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = filteredMovies[index];
          return _buildMovieCard(movie, index);
        },
      ),
    );
  }

  Widget _buildMovieCard(Map<String, dynamic> movie, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'custom_list_movies_item',
            arguments: movie);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/movies/${movie['avatar']}.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      movie['category'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Estreno: ${movie['releaseDate']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _toggleFavorite(index),
                icon: Icon(
                  movie['isFavorite'] ? Icons.star : Icons.star_border,
                  color: movie['isFavorite'] ? Colors.yellow : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
