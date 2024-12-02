import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/tv_series_mock.dart';

class RecordListScreen extends StatefulWidget {
  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Series de TV'),
      ),
      body: ListView.builder(
        itemCount: tvSeriesMock.length,
        itemBuilder: (context, index) {
          final record = tvSeriesMock[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(context, 'record_details', arguments: record);
              setState(() {});
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.asset(
                  record['image'],
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
                title: Text(record['title']),
                subtitle: Text(record['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(record['favorite'] ? Icons.star : Icons.star_border),
                    Switch(
                      value: record['active'],
                      onChanged: (value) {
                        setState(() {
                          record['active'] = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
