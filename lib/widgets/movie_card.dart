import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/RatingCircle.dart';

class MovieCard extends StatelessWidget {
  final String poster;
  final String title;
  final String overview; // Cambiamos category por overview
  final double rating;
  final int id;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap;

  const MovieCard({
    required this.poster,
    required this.title,
    required this.overview, // Cambiamos category por overview
    required this.rating,
    required this.id,
    required this.isFavorite,
    this.onFavoriteToggle,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenedor para la imagen
            Container(
              height: 200, // Ajusta la altura de la imagen
              width: double.infinity, // Ocupa todo el ancho
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500$poster"),
                  fit: BoxFit.cover, // Ajusta la imagen para cubrir el espacio
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sinopsis: $overview', // Cambiamos "Categoría" por "Sinopsis"
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 3, // Limita el número de líneas para evitar que ocupe mucho espacio
                    overflow: TextOverflow.ellipsis, // Muestra "..." si el texto es demasiado largo
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingCircle(rating: rating),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border_outlined,
                          color: isFavorite ? Colors.yellow : Colors.grey,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}