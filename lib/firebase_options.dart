// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
    apiKey: 'AIzaSyCEAbwbg0qbh6VhOnJPgfQFrwaWclHjiDk',
    appId: '1:864408400900:web:92fcfb84679aaad5a93151',
    messagingSenderId: '864408400900',
    projectId: 'test-app-385d1',
    authDomain: 'test-app-385d1.firebaseapp.com',
    storageBucket: 'test-app-385d1.appspot.com',
    measurementId: 'G-PQHNH3080Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ-bosiOhv3FGmLeB_NfjIaZwf-VPeU58',
    appId: '1:864408400900:android:a98793256a62e374a93151',
    messagingSenderId: '864408400900',
    projectId: 'test-app-385d1',
    storageBucket: 'test-app-385d1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJd5nj-A3RpRZ0psxwok60t4NDKx-scPA',
    appId: '1:864408400900:ios:0e2f28485a1d8bafa93151',
    messagingSenderId: '864408400900',
    projectId: 'test-app-385d1',
    storageBucket: 'test-app-385d1.appspot.com',
    iosBundleId: 'com.example.testApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJd5nj-A3RpRZ0psxwok60t4NDKx-scPA',
    appId: '1:864408400900:ios:6cae24b7fd17a15aa93151',
    messagingSenderId: '864408400900',
    projectId: 'test-app-385d1',
    storageBucket: 'test-app-385d1.appspot.com',
    iosBundleId: 'com.example.testApp.RunnerTests',
  );
}