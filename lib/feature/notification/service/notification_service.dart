
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart'; // Import logger package

class NotificationService {
  final Dio _dio;
  final Logger _logger = Logger();

  NotificationService._init()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://10.0.2.2:5000/api/Users',
        ));

  static final NotificationService _instance = NotificationService._init();
  static NotificationService get instance => _instance;

  Future<Works?> createWork(int userId, Works work) async {
    try {
      final response = await _dio.post(
        '/$userId/content',
        data: work.toJson(),
      );

      _logger.i('Response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        return Works.fromJson(response.data);
      }
    } on DioException catch (e) {
      _logger.e('Dio error: ${e.message}');
    } catch (e) {
      _logger.e('Unexpected error: $e');
    }
    return null;
  }

  Future<bool> deleteWork(int userId, int workId) async {
    try {
      final response = await _dio.delete('/$userId/content/$workId');
      _logger.i('Delete response status: ${response.statusCode}');

      return response.statusCode == 204;
    } on DioException catch (e) {
      _logger.e('Dio error during delete: ${e.message}');
      if (e.response != null) {
        _logger.w('Response status: ${e.response?.statusCode}');
        _logger.w('Response data: ${e.response?.data}');
      }
    } catch (e) {
      _logger.e('Unexpected error during delete: $e');
    }
    return false;
  }
}
