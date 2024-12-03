import 'package:flutter/material.dart';
import '../models/tvSeriesModel.dart';

class RecordDetailsScreen extends StatefulWidget {
  const RecordDetailsScreen({super.key});

  @override
  State<RecordDetailsScreen> createState() => _RecordDetailsScreenState();
}

class _RecordDetailsScreenState extends State<RecordDetailsScreen> {
  late Result record;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    record = ModalRoute.of(context)!.settings.arguments as Result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.name),
        actions: [
          IconButton(
            icon: Icon(
              record.isFavorite ? Icons.star : Icons.star_border,
              color: record.isFavorite ? Colors.yellow : null,
            ),
            onPressed: () {
              setState(() {
                record.isFavorite = !record.isFavorite;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${record.posterPath}",
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              record.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              record.overview,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popularidad: ${record.popularity}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    record.isFavorite ? Icons.star : Icons.star_border,
                    color: record.isFavorite ? Colors.yellow : null,
                  ),
                  onPressed: () {
                    setState(() {
                      record.isFavorite = !record.isFavorite;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}