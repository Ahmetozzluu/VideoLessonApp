import 'package:dersgo_app/feature/home/view/home_view.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/profile/view/profile_view.dart';
import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/feature/video/view/video_view.dart';
import 'package:dersgo_app/feature/login/view/login_view.dart';
import 'package:dersgo_app/feature/register/view/register_view.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    ),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => RegisterView(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>;
      final user = extras['user'] as List<UserModel>?;
      final loginCubit = extras['loginCubit'] as LoginCubit;

      return BlocProvider.value(
        value: loginCubit, // Doğru LoginCubit'i sağlayın
        child: HomeView(
          user: user, // Kullanıcı listesini HomeView'e geçin
        ),
      );
    },
  ),
  GoRoute(
    path: '/video',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>;
      final video = extras['video'] as Videos;
      final videos = extras['videos'] as List<Videos>?;
      //final videoCubit = extras['videoCubit'] as VideoCubit;
      // final video = state.extra as Videos;
      return BlocProvider.value(
        value:
            (state.extra as Map<String, dynamic>)["videoCubit"] as VideoCubit,
        child: VideoView(
          videos: videos,
          video: video,
        ),
      );
    },
  ),
  GoRoute(
      path: '/profile',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LoginCubit(),
          child: const ProfileView(),
        );
      })
]);
