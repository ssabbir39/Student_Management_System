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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCfase-bgw4-VXBgla7clfhpjyVMy3vnOk',
    appId: '1:427125638558:web:9d198beb5abd9071ba028f',
    messagingSenderId: '427125638558',
    projectId: 'student-management-33a89',
    authDomain: 'student-management-33a89.firebaseapp.com',
    storageBucket: 'student-management-33a89.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuvwntRPueTAQW_4Vv7z-fzD8nSleYn9I',
    appId: '1:427125638558:android:ca0f2cb0ef1e70b7ba028f',
    messagingSenderId: '427125638558',
    projectId: 'student-management-33a89',
    storageBucket: 'student-management-33a89.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBn4HV2eKJj6JWqUs2d2dGzAyyj65NZveg',
    appId: '1:427125638558:ios:d618af830a30ed84ba028f',
    messagingSenderId: '427125638558',
    projectId: 'student-management-33a89',
    storageBucket: 'student-management-33a89.appspot.com',
    iosBundleId: 'com.example.studentManagementSystem',
  );
}