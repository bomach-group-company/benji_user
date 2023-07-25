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
    apiKey: 'AIzaSyCCzFIGCY8nN71TGOxKTi94839RIrQzc9E',
    appId: '1:1020593391839:web:19d75d1a279abeec31816a',
    messagingSenderId: '1020593391839',
    projectId: 'benji-18de3',
    authDomain: 'benji-18de3.firebaseapp.com',
    storageBucket: 'benji-18de3.appspot.com',
    measurementId: 'G-98XQKEY674',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1NF_aC8Tx_zTqKdSHGenz3460djHrVcE',
    appId: '1:1020593391839:android:c287bd2ccce72f8c31816a',
    messagingSenderId: '1020593391839',
    projectId: 'benji-18de3',
    storageBucket: 'benji-18de3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjx7W9s_at9bkxl1yQlCiNq2rsil1Si4c',
    appId: '1:1020593391839:ios:25f9672be37b92e831816a',
    messagingSenderId: '1020593391839',
    projectId: 'benji-18de3',
    storageBucket: 'benji-18de3.appspot.com',
    iosClientId: '1020593391839-1b09vabhpkf4mfpcv24t4f1rs48ln26q.apps.googleusercontent.com',
    iosBundleId: 'com.example.benjiUser',
  );
}