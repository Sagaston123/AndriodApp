import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
final String poster;
  final String title;
  final String category;
  final double rating;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap;

  const MovieCard({
    required this.poster,
    required this.title,
    required this.category,
    required this.rating,
    required this.isFavorite,
    this.onFavoriteToggle,
    this.onTap,
    super.key,
  });

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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/posters_estrenos/$poster.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
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
                    'Categoría: $category',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingCircle(rating: rating),
                    Icon(
                      isFavorite ? Icons.star : Icons.star_border_outlined,
                      color: isFavorite ? Colors.yellow : Colors.grey,
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

class RatingCircle extends StatelessWidget {
  final double rating;

  const RatingCircle({Key? key, required this.rating}) : super(key: key);

  Color _getRatingColor(double rating) {
    if (rating < 50) return Colors.red; 
    if (rating < 75) return Colors.amber;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getRatingColor(rating), 
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
