/*import 'dart:convert';
import 'dart:io';

import 'package:dersgo_app/feature/video/service/ivideo_service.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class VideoService implements IVideoService {
  final Dio _dio;
  final Logger _logger = Logger();

  VideoService._init()
      : _dio = Dio(BaseOptions(
            baseUrl: 'http://10.0.2.2:5000/api/Users',
            connectTimeout: const Duration(seconds: 5000),
            receiveTimeout: const Duration(seconds: 5000)));

  static final VideoService _instance = VideoService._init();
  static VideoService get instance => _instance;



@override
Future<bool?> updateLastWatch(
    int userId, List<String> lastWatchedVideos) async {
  try {
    final response = await _dio.put(
      "/videos",
      queryParameters: {
        'userId': userId,
      },
      data: jsonEncode(lastWatchedVideos), // Listeyi JSON formatında gönderiyoruz
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
*/