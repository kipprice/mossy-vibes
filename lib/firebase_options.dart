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
    apiKey: 'AIzaSyCSV4Wx7qNDefpBcI3L8g8KSrfAwayq5OU',
    appId: '1:466747772062:web:918983d574e5bc59f2ff8f',
    messagingSenderId: '466747772062',
    projectId: 'mossy-vibes',
    authDomain: 'mossy-vibes.firebaseapp.com',
    storageBucket: 'mossy-vibes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhYYXlV38CddVf2TyvGDg5NU-BfudXtzQ',
    appId: '1:466747772062:android:8eaddb4655363d64f2ff8f',
    messagingSenderId: '466747772062',
    projectId: 'mossy-vibes',
    storageBucket: 'mossy-vibes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTqxIoJXBdcx6TqZ-sbrrEDkVYReLZ00k',
    appId: '1:466747772062:ios:19a87d3471f0c034f2ff8f',
    messagingSenderId: '466747772062',
    projectId: 'mossy-vibes',
    storageBucket: 'mossy-vibes.appspot.com',
    iosClientId:
        '466747772062-ocoq0f4hruhovf4m54furjjnojnektka.apps.googleusercontent.com',
    iosBundleId: 'com.kipprice.mossyVibes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTqxIoJXBdcx6TqZ-sbrrEDkVYReLZ00k',
    appId: '1:466747772062:ios:5a7904f9c7c454a6f2ff8f',
    messagingSenderId: '466747772062',
    projectId: 'mossy-vibes',
    storageBucket: 'mossy-vibes.appspot.com',
    iosClientId:
        '466747772062-69er48llra44qvgfpbs3aiprsqcagpf9.apps.googleusercontent.com',
    iosBundleId: 'com.kipprice.mossyVibes.RunnerTests',
  );
}
