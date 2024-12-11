import 'dart:io';

import 'package:dersgo_app/feature/lesson/service/ilesson_service.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LessonService implements ILessonService {
  final Dio _dio;
  final Logger _logger = Logger();

  LessonService._init()
      : _dio = Dio(BaseOptions(
            baseUrl: 'http://10.0.2.2:5000/api/Users',
            connectTimeout: const Duration(seconds: 5000),
            receiveTimeout: const Duration(seconds: 5000)));

  static final LessonService _instance = LessonService._init();
  static LessonService get instance => _instance;

@override
Future<bool?> updateLastWatch(
    int userId, List<String> lastWatchedVideos) async {
  try {
    final response = await _dio.put(
      "/videos",
      queryParameters: {
        'userId': userId,
      },
      data: lastWatchedVideos,
    );

    if (response.statusCode == HttpStatus.ok) {
      _logger.i(
          "Successfully updated last watched videos. Response status: ${response.statusCode}");
      return true;
    } else {
      _logger.w("Unexpected response status: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    _logger.e("Error updating last watched videos: $e");
    return null; // Hata durumunda açıkça null döner
  }
}

}
