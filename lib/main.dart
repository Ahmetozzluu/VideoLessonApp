// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dersgo_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dersgo_app/feature/settings/view/cubit/settings_cubit.dart';
import 'package:dersgo_app/product/routes/app_route.dart';
import 'package:dersgo_app/product/theme/app_theme.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => const Material();
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final isDarkTheme = prefs.getBool('isDarkTheme') ?? false; 

  OneSignal.Debug.setLogLevel(OSLogLevel.debug);
  OneSignal.initialize('ecf9b076-e813-4e24-a4f2-2add041d1c47');
  OneSignal.Notifications.requestPermission(true);

  runApp(MyApp(isDarkTheme: isDarkTheme));
}
class MyApp extends StatelessWidget {
  final bool isDarkTheme;
  const MyApp({
    super.key,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
         create: (context) {
          final settingsCubit = SettingsCubit();
          settingsCubit.isThemeChanged(isDarkTheme);
          return settingsCubit;
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: state.isTheme
                  ? AppThemeManager.darkTheme
                  : AppThemeManager
                      .lightTheme, 
              routerConfig:
                  router,
            );
          },
        ),
      ),
    );
  }
}


//  BlocProvider(create: (context) => SettingsCubit()..isThemeChanged(isDarkTheme)),


// her kullanıcının izlediği son beş videonun getirilmesi gerek eğer izlediği son 5 video yoksa rasgele listeden videolar göster.





/*
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Cubit created: ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('Cubit closed: ${bloc.runtimeType}');
  }
}

void main() async {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}login cubitin kapanıp kapanmadığını görebilirmişiz 
 */