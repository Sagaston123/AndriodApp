
import 'package:flutter/material.dart';
class RatingCircle extends StatelessWidget {
  final double rating;

  const RatingCircle({Key? key, required this.rating}) : super(key: key);

  Color _getRatingColor(double rating) {
    if (rating < 5) return Colors.red;
    if (rating < 7.5) return Colors.amber;
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