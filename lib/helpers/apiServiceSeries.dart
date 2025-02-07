import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tvSeriesModel.dart';

class ApiServiceSeries {
  final String baseUrl;

  ApiServiceSeries(this.baseUrl);

  Future<List<Result>> fetchSeries() async {
    final url = Uri.parse("$baseUrl/app/series/top_rated");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final seriesData = Welcome.fromJson(data).data.results;
      return seriesData;
    } else {
      throw Exception("Error al cargar las series: ${response.statusCode}");
    }
  }
}
