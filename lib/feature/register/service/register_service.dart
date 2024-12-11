import 'dart:io';
import 'dart:developer' as log;
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:dersgo_app/product/global/service/auth/IAuth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterService extends IRegisterService {
  final Dio _dio;

  RegisterService._init()
      : _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000/api'));

  static final RegisterService _instance = RegisterService._init();
  static RegisterService get instance => _instance;

  @override
  Future<void> userCreate(UserModel user, BuildContext context) async {
    try {
      final response = await _dio.post(
        '/Users',
        data: {
          "name": user.name,
          "firstName": user.firstName,
          "email": user.email,
          "password": user.password,
          // Ek alanlar eklenebilir
        },
      );
      if (response.statusCode == HttpStatus.created) {
        log.log("Kullanıcı başarıyla oluşturuldu.", name: 'RegisterService');
        // Başarı mesajı ve yönlendirme
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kullanıcı başarıyla oluşturuldu.")),
        );
        // Home sayfasına git
       //context.pop("/");
      } else {
        log.log(
          "Kullanıcı oluşturulamadı, durum kodu: ${response.statusCode}",
          name: 'RegisterService',
          level: 1000,
        );
        // Eğer kullanıcı oluşturulamadıysa, hata mesajı göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kullanıcı oluşturulamadı. Durum kodu: ${response.statusCode}')),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bu e-posta adresi zaten kullanımda.")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata: ${e.response?.data}')),
          );
        }
      } else {
        log.log(
          "Dio ile bağlantı hatası: ${e.message}",
          name: 'RegisterService',
          level: 1000,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Bağlantı hatası oluştu.")),
        );
      }
    } catch (e) {
      log.log(
        "Bilinmeyen bir hata oluştu: $e",
        name: 'RegisterService',
        level: 1000,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilinmeyen bir hata oluştu.')),
      );
    }
  }
}
