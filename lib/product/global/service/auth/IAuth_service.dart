import 'package:dersgo_app/feature/login/model/login_repsonse.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter/material.dart';


abstract class ILoginService {
  Future<LoginResponseModel?> userLogin(String email, String password);
  Future<List<UserModel>?> getUser(int id);
  Future<Videos?> updateVideo(int userId, int videoId, Videos videoData); // t type laara bak.
  Future<bool?> updateUserActive(int id, bool isActive);
  
}

abstract class IRegisterService {
  Future<void> userCreate(UserModel user, BuildContext context);
}