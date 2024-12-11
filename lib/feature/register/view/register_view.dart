import 'package:dersgo_app/core/utils/validation_service.dart';
import 'package:dersgo_app/feature/register/service/register_service.dart';
import 'package:dersgo_app/product/constants/app_color.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterService _registerService = RegisterService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    "Hoşgeldiniz",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 120.h),
                  _customTextFormField(
                    controller: nameController,
                    title: "Ad",     
                    icon: const Icon(Icons.person),
                    validator: ValidationService.validateName,
                  ),
                  SizedBox(height: 7.h),
                  _customTextFormField(
                    controller: userNameController,
                    title: "Soyad",
                    icon: const Icon(Icons.badge),
                    validator: ValidationService.validateUserName,
                  ),
                  SizedBox(height: 7.h),
                  _customTextFormField(
                    controller: emailController,
                    title: "Email",
                    icon: const Icon(Icons.mail),
                    validator: ValidationService.validateEmail,
                  ),
                  SizedBox(height: 7.h),
                  _customTextFormField(
                    controller: passwordController,
                    title: "Şifre",
                    icon: const Icon(Icons.key),
                    validator: ValidationService.validatePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 40.h),
                  SizedBox(
                      width: 250.h,
                      height: 50.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            UserModel user = UserModel(
                              name: nameController.text,
                              firstName: userNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            await _registerService.userCreate(user, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Lütfen istenilen bilgileri doğru ve eksiksiz bir şekilde giriniz.')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: const Color.fromARGB(255, 97, 148, 235),
                          elevation: 7,
                        ),
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(fontSize: 20.sp),
                          
                        ),
                      )),
                  SizedBox(height: 30.h),
                  TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                    ),
                    onPressed: () {
                      context.pop("/");
                    },
                    child: Text(
                      "Zaten kayıtlıyım",
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextFormField({
    required TextEditingController controller,
    required String title,
    required Icon icon,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          hintText: title,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
