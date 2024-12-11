// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCqyo6nKZd_uRvXXfgJNUB3cnpyO5Osqrg',
    appId: '1:1022097584747:web:436be7ae9e78ea0ad8372e',
    messagingSenderId: '1022097584747',
    projectId: 'worknotification',
    authDomain: 'worknotification.firebaseapp.com',
    storageBucket: 'worknotification.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4qHs0UqDy6v8KjGW3GxFMlaOEUsn8lnY',
    appId: '1:1022097584747:android:221a7c23cb073d4cd8372e',
    messagingSenderId: '1022097584747',
    projectId: 'worknotification',
    storageBucket: 'worknotification.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPy-UHCklMHjO5BZAZkgo-Lze9XPcUOfc',
    appId: '1:1022097584747:ios:d89582cd9814f3d0d8372e',
    messagingSenderId: '1022097584747',
    projectId: 'worknotification',
    storageBucket: 'worknotification.firebasestorage.app',
    iosBundleId: 'com.example.dersgoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPy-UHCklMHjO5BZAZkgo-Lze9XPcUOfc',
    appId: '1:1022097584747:ios:d89582cd9814f3d0d8372e',
    messagingSenderId: '1022097584747',
    projectId: 'worknotification',
    storageBucket: 'worknotification.firebasestorage.app',
    iosBundleId: 'com.example.dersgoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCqyo6nKZd_uRvXXfgJNUB3cnpyO5Osqrg',
    appId: '1:1022097584747:web:a25efd9de76e0566d8372e',
    messagingSenderId: '1022097584747',
    projectId: 'worknotification',
    authDomain: 'worknotification.firebaseapp.com',
    storageBucket: 'worknotification.firebasestorage.app',
  );
}