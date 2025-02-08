import 'package:flutter/material.dart';
import '../models/movie.dart'; // Asegúrate de importar el modelo Movie

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Se extrae la instancia de Movie enviada como argumento
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF2D2F3B),
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              HeaderMovieDetails(
                size: size,
                movieImage: movie.posterPath,
              ),
              const SizedBox(height: 30),
              BodyMovieDetails(movie: movie),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyMovieDetails extends StatelessWidget {
  final Movie movie;

  const BodyMovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        _buildTextField('Título de la película', movie.title),
        const SizedBox(height: 20),
        _buildTextField('Género', movie.category),
        const SizedBox(height: 20),
        _buildTextField('Año de estreno', movie.releaseDate),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: decorationInput(label: label),
      readOnly: true,
    );
  }

  InputDecoration decorationInput({
    IconData? icon,
    String? hintText,
    String? helperText,
    String? label,
  }) {
    return InputDecoration(
      labelText: label ?? '',
      hintText: hintText,
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.blueAccent,
      ),
      prefixIcon: (icon != null) ? Icon(icon, color: Colors.blueAccent) : null,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      filled: true,
      fillColor: const Color(0xFF4A4A4A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
    );
  }
}

class HeaderMovieDetails extends StatelessWidget {
  final Size size;
  final String? movieImage;

  const HeaderMovieDetails({
    super.key,
    this.movieImage,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF212121), Color(0xFF37474F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(0, 10),
            blurRadius: 30,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size.width * 0.45,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: movieImage != null && movieImage!.isNotEmpty
                  ? NetworkImage("https://image.tmdb.org/t/p/w500$movieImage")
                  : const AssetImage('assets/loading.gif') as ImageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
