import 'dart:developer'; // dart:developer paketini ekleyin
import 'dart:io';
import 'package:dersgo_app/feature/login/model/login_repsonse.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:dersgo_app/product/global/service/auth/IAuth_service.dart';
import 'package:dio/dio.dart';

class LoginService implements ILoginService {
  final Dio _dio;

  LoginService._init()
      : _dio = Dio(BaseOptions(
            baseUrl: 'http://10.0.2.2:5000/api/Users',
            connectTimeout: const Duration(seconds: 5000),
            receiveTimeout: const Duration(seconds: 5000)));

  static final LoginService _instance = LoginService._init();
  static LoginService get instance => _instance;

  @override
  Future<LoginResponseModel?> userLogin(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        queryParameters: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        // await LocalStorage().saveString('email', email);
        // await LocalStorage().saveString('password', password);

        return LoginResponseModel.fromJson(response.data);
      } else {
        log('Login failed', name: 'LoginService');
        return LoginResponseModel(success: false, errorMessage: 'Login failed');
      }
    } catch (e) {
      log('Login error: $e', name: 'LoginService', error: e);
      return LoginResponseModel(
          success: false, errorMessage: 'An error occurred');
    }
  }

  @override
  Future<List<UserModel>?> getUser(int id) async {
    try {
      final response = await _dio.get("/$id/content");

      if (response.statusCode == HttpStatus.ok) {
        List<UserModel> users = (response.data as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
        return users;
      } else {
        log('User data could not be loaded: ${response.statusCode}',
            name: 'LoginService');
        return null;
      }
    } catch (e) {
      log('Error fetching user data: $e', name: 'LoginService', error: e);
      return null;
    }
  }

  @override
  Future<Videos?> updateVideo(int userId, int videoId, Videos videoData) async {
    try {
      final response = await _dio.put("/$userId/content",
          queryParameters: {
            'videoId': videoId,
          },
          data: videoData.toJson());
      if (response.statusCode == 200) {
        return Videos.fromJson(response.data);
      } else {
        log('Güncelleme işlemi başarısız: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('Hata: $e');
      return null;
    }
  }

  @override
  Future<bool?> updateUserActive(int userId, bool isActive) async {
    try {
      final response = await _dio.put(
        "/$userId",
        data: {
          "isActive": isActive,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        log('Failed to update user active status: ${response.statusCode}',
            name: 'LoginService');
        return false;
      }
    } catch (e) {
      log('Error updating user active status: $e',
          name: 'LoginService', error: e);
      return false;
    }
  }
}
