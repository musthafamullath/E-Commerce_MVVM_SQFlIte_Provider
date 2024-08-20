// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await _dio.get(Urls.api());

      if (response.statusCode == 200) {
        print("Successfully fetched");
        final data = response.data as List<dynamic>;
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

