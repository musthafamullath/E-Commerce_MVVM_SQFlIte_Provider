// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<String> saveImageToFileSystem(String imageUrl, String fileName) async {
  final Dio dio = Dio();

  try {
    final response = await dio.get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName';
      print(path);
      final file = File(path);
      await file.writeAsBytes(response.data!);
      return path;
    } else {
      throw Exception('Failed to load image');
    }
  } catch (e) {
    throw Exception('Failed to load image: $e');
  }
}

