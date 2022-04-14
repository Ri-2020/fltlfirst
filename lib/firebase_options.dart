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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCzzBzXzVxRh_eyvyRYyFHxUlHWSBSzL-Y',
    appId: '1:360078000368:web:e2ac1a3691e94f92ecc235',
    messagingSenderId: '360078000368',
    projectId: 'notesa',
    authDomain: 'notesa.firebaseapp.com',
    storageBucket: 'notesa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZtg8u8FB6HTqusHPitYGdX0nhyrCV64g',
    appId: '1:360078000368:android:1336aab72d2f45d8ecc235',
    messagingSenderId: '360078000368',
    projectId: 'notesa',
    storageBucket: 'notesa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLxgSf6EcxiV_wJqQNaU3s_Oh0m7uPbEQ',
    appId: '1:360078000368:ios:fa2b73785b759cbeecc235',
    messagingSenderId: '360078000368',
    projectId: 'notesa',
    storageBucket: 'notesa.appspot.com',
    iosClientId: '360078000368-dvtnbi6h9j7ev5fjdst65v4adj8s9a1u.apps.googleusercontent.com',
    iosBundleId: 'biz.my.notesapp',
  );
}