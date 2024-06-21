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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbkUPjrXGsbUXarTHd-97K63JpyVkPlNQ',
    appId: '1:622241807603:android:186c47b8122750aa870b86',
    messagingSenderId: '622241807603',
    projectId: 'catt-catt',
    databaseURL: 'https://catt-catt-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'catt-catt.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVQw8UydGYksUtS2M2vdamGhmAbUVLmGo',
    appId: '1:622241807603:ios:9eef52d2f3e1b6c5870b86',
    messagingSenderId: '622241807603',
    projectId: 'catt-catt',
    databaseURL: 'https://catt-catt-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'catt-catt.appspot.com',
    androidClientId: '622241807603-n8o1n68n11lav1glqo5b9g2cvfvod00k.apps.googleusercontent.com',
    iosClientId: '622241807603-dfi8eri9qg2v6kmnufa54tob7fm3fqbg.apps.googleusercontent.com',
    iosBundleId: 'com.cattcatt.cattCatt',
  );

}