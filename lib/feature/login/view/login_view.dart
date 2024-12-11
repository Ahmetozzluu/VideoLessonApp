import 'package:dersgo_app/core/utils/validation_service.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/login/cubit/login_state.dart';
import 'package:dersgo_app/product/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
    if (savedPassword != null) {
      passwordController.text = savedPassword;
    }
  }

  void userSaved(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state.loginState == LoginStates.completed &&
                state.user != null) {
              context
                  .read<LoginCubit>()
                  .updateLastWatched(state.user![0].id!, state.user![0].videos);
              context.push(
                '/home',
                extra: {
                  'user': state.user,
                  'loginCubit': context.read<LoginCubit>(),
                },
              );
              userSaved(emailController.text, passwordController.text);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            } else if (state.loginState == LoginStates.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    Text(
                      "Hoşgeldiniz",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(
                      "assets/png/1.png",
                      width: 130.w,
                      height: 120.h,
                    ),
                    SizedBox(height: 50.h),
                    _customTextFormField(
                      context: context,
                      controller: emailController,
                      title: "Email",
                      icon: const Icon(Icons.mail),
                      validator: ValidationService.validateEmail,
                    ),
                    SizedBox(height: 7.h),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return _customTextFormField(
                          context: context,
                          controller: passwordController,
                          title: "Şifre",
                          icon: const Icon(Icons.key),
                          validator: ValidationService.validatePassword,
                          obscureText: state.isSecure,
                          isPasswordField: true,
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state.loginState == LoginStates.loading) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: 250.h,
                          height: 50.w,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<LoginCubit>().userLogin(
                                      emailController.text,
                                      passwordController.text,
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Lütfen istenilen bilgileri doğru ve eksiksiz bir şekilde giriniz.')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor:
                                  const Color.fromARGB(255, 97, 148, 235),
                              elevation: 7,
                            ),
                            child: Text(
                              "Giriş yap",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () {
                        context.push("/register");
                      },
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
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
    required BuildContext context,
    bool isPasswordField = false,
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
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: obscureText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    context.read<LoginCubit>().obsecure();
                  },
                )
              : null,
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
