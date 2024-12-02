import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detalles de la Película',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF2D2F3B), 
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 25.0), 
          child: Column(
            children: [
              HeaderMovieDetails(
                size: size,
                movieImage: args['avatar'],
              ),
              const SizedBox(
                  height: 30), 
              BodyMovieDetails(args: args),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyMovieDetails extends StatelessWidget {
  final Map<String, dynamic> args;

  const BodyMovieDetails({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        const SizedBox(height: 15),
        _buildTextField('Título de la película', args['name']),
        const SizedBox(height: 20),
        _buildTextField('Género', args['category']),
        const SizedBox(height: 20),
        _buildTextField('Año de estreno', args['releaseDate']),
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
        gradient: LinearGradient(
          colors: [
            Color(0xFF212121),
            Color(0xFF37474F)
          ], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft:
              Radius.circular(25), 
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: Offset(0, 10),
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
              image: AssetImage(
                movieImage != null
                    ? 'assets/movies/$movieImage.jpg'
                    : 'assets/loading.gif',
              ),
              fit: BoxFit.contain, 
            ),
          ),
        ),
      ),
    );
  }
}
