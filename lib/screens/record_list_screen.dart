import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/apiServiceSeries.dart';
import 'package:flutter_application_base/models/tvSeriesModel.dart';
import 'package:provider/provider.dart';


class RecordListScreen extends StatefulWidget {
  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  late Future<List<Result>> _seriesFuture;

@override
void initState() {
  super.initState();
  final apiService = Provider.of<ApiServiceSeries>(context, listen: false);
  _seriesFuture = apiService.fetchSeries();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Series de TV'),
      ),
      body: FutureBuilder<List<Result>>(
        future: _seriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay series disponibles'));
          } else {
            final series = snapshot.data!;
            return ListView.builder(
              itemCount: series.length,
              itemBuilder: (context, index) {
                final record = series[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      'record_details',
                      arguments: record,
                    );
                    setState(() {});
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: Image.network(
                        "https://image.tmdb.org/t/p/w500${record.posterPath}",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                      title: Text(record.name),
                      subtitle: Text(record.overview),
                      trailing: Icon(Icons.star_border),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
