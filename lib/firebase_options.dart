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
    apiKey: 'AIzaSyCWP4mtXtEKlv6M4a0cnjRPA-KMryyt_Ns',
    appId: '1:914133702565:web:01cd070722a5296e343a4c',
    messagingSenderId: '914133702565',
    projectId: 'fir-miner-1d3dc',
    authDomain: 'fir-miner-1d3dc.firebaseapp.com',
    storageBucket: 'fir-miner-1d3dc.appspot.com',
    measurementId: 'G-T44SHX4QFQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAG8rH0OzBQnrnWUQtUAMMgti8s8i_SQX4',
    appId: '1:914133702565:android:8e63f9c15c31707a343a4c',
    messagingSenderId: '914133702565',
    projectId: 'fir-miner-1d3dc',
    storageBucket: 'fir-miner-1d3dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_0PVTeOWM_W4BBaxuQqPfodohjYweukU',
    appId: '1:914133702565:ios:c883d678f9bcb74a343a4c',
    messagingSenderId: '914133702565',
    projectId: 'fir-miner-1d3dc',
    storageBucket: 'fir-miner-1d3dc.appspot.com',
    iosBundleId: 'com.example.firebaseMiner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_0PVTeOWM_W4BBaxuQqPfodohjYweukU',
    appId: '1:914133702565:ios:6fac65692fe7368c343a4c',
    messagingSenderId: '914133702565',
    projectId: 'fir-miner-1d3dc',
    storageBucket: 'fir-miner-1d3dc.appspot.com',
    iosBundleId: 'com.example.firebaseMiner.RunnerTests',
  );
}
