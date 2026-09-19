import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with `Firebase.initializeApp`.
///
/// To connect to your real Firebase backend:
/// 1. Run `flutterfire configure` in your terminal OR
/// 2. Download `google-services.json` from Firebase Console into `android/app/`.
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
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyForCampusBarter12345',
    appId: '1:1234567890:web:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'campus-barter-demo',
    authDomain: 'campus-barter-demo.firebaseapp.com',
    storageBucket: 'campus-barter-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyForCampusBarter12345',
    appId: '1:1234567890:android:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'campus-barter-demo',
    storageBucket: 'campus-barter-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyForCampusBarter12345',
    appId: '1:1234567890:ios:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'campus-barter-demo',
    storageBucket: 'campus-barter-demo.appspot.com',
    iosBundleId: 'com.example.peerlink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyForCampusBarter12345',
    appId: '1:1234567890:ios:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'campus-barter-demo',
    storageBucket: 'campus-barter-demo.appspot.com',
    iosBundleId: 'com.example.peerlink',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyForCampusBarter12345',
    appId: '1:1234567890:web:demoapp',
    messagingSenderId: '1234567890',
    projectId: 'campus-barter-demo',
    authDomain: 'campus-barter-demo.firebaseapp.com',
    storageBucket: 'campus-barter-demo.appspot.com',
  );
}
