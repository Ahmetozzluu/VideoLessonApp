
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final LoginStates? loginState;
  final String? errorMessage;
  final String? message;
  final List<UserModel>? user;
  final List<Videos>? lastWatchedVideo;
  final Videos? updateVideo;
  final bool isSecure;


  const LoginState({
    this.user,
    this.loginState,
    this.errorMessage,
    this.message,
    this.lastWatchedVideo,
    this.updateVideo,
    required this.isSecure,
  });

  factory LoginState.initial() {
    return const LoginState(
        loginState: LoginStates.initial,
        errorMessage: '',
        message: '',
        user: null,
        lastWatchedVideo: null,
        updateVideo: null,
        isSecure: true);
  }

  @override
  List<Object?> get props =>
      [loginState, errorMessage, message, user, lastWatchedVideo, updateVideo,isSecure];

  LoginState copyWith({
    LoginStates? loginState,
    String? errorMessage,
    String? message,
    List<UserModel>? user,
    List<Videos>? lastWatchedVideo,
    Videos? updateVideo,
    bool? isSecure,
  }) {   
    return LoginState(
      loginState: loginState ?? this.loginState,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      user: user ?? this.user,
      lastWatchedVideo: lastWatchedVideo ?? this.lastWatchedVideo,
      updateVideo: updateVideo ?? this.updateVideo,
      isSecure: isSecure ?? this.isSecure,
    );
  }
}

enum LoginStates {
  isNotActive,
  initial,
  loading,
  completed,
  error,
}

