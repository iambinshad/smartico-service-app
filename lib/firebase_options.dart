// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA5YKmEDA7cmj3uwarJwz0-M6yY7YnNILA',
    appId: '1:567250082750:web:ea6670ad6e2292353cf7ef',
    messagingSenderId: '567250082750',
    projectId: 'smartico-chat-app',
    authDomain: 'smartico-chat-app.firebaseapp.com',
    storageBucket: 'smartico-chat-app.appspot.com',
    measurementId: 'G-8WEDZX64E0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP2Uke0YA7xzb_LgvkzjOrxEX7tOTrS9o',
    appId: '1:567250082750:android:04937819ee72c43b3cf7ef',
    messagingSenderId: '567250082750',
    projectId: 'smartico-chat-app',
    storageBucket: 'smartico-chat-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa9ep_Er8-iJAsPETkYK2z-_n1H-5dneY',
    appId: '1:567250082750:ios:2613e729654375bb3cf7ef',
    messagingSenderId: '567250082750',
    projectId: 'smartico-chat-app',
    storageBucket: 'smartico-chat-app.appspot.com',
    iosClientId: '567250082750-ec1o5cn8h9g0n0arr99l1pf5dudi5mqt.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartico',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAa9ep_Er8-iJAsPETkYK2z-_n1H-5dneY',
    appId: '1:567250082750:ios:2613e729654375bb3cf7ef',
    messagingSenderId: '567250082750',
    projectId: 'smartico-chat-app',
    storageBucket: 'smartico-chat-app.appspot.com',
    iosClientId: '567250082750-ec1o5cn8h9g0n0arr99l1pf5dudi5mqt.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartico',
  );
}