import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA0eTadU51-A63G2TgtxYK0bmI-iEVUd_Q',
    appId: '1:291606428802:web:991926db9a616d2cb6c89b',
    messagingSenderId: '291606428802',
    projectId: 'movieapp-6adca',
    authDomain: 'movieapp-6adca.firebaseapp.com',
    storageBucket: 'movieapp-6adca.firebasestorage.app',
    measurementId: 'G-VVGXL7MMBG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEGMOppbUzQg1lBg9FwyedQNGu6ooM8yE',
    appId: '1:291606428802:android:3cc3bca058663ea2b6c89b',
    messagingSenderId: '291606428802',
    projectId: 'movieapp-6adca',
    storageBucket: 'movieapp-6adca.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAE6qs-VZQFpalkzKKQRYePbnnWBzVNIYY',
    appId: '1:291606428802:ios:aa5ad0a1c5146851b6c89b',
    messagingSenderId: '291606428802',
    projectId: 'movieapp-6adca',
    storageBucket: 'movieapp-6adca.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAE6qs-VZQFpalkzKKQRYePbnnWBzVNIYY',
    appId: '1:291606428802:ios:aa5ad0a1c5146851b6c89b',
    messagingSenderId: '291606428802',
    projectId: 'movieapp-6adca',
    storageBucket: 'movieapp-6adca.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA0eTadU51-A63G2TgtxYK0bmI-iEVUd_Q',
    appId: '1:291606428802:web:09f3d2eac7723e08b6c89b',
    messagingSenderId: '291606428802',
    projectId: 'movieapp-6adca',
    authDomain: 'movieapp-6adca.firebaseapp.com',
    storageBucket: 'movieapp-6adca.firebasestorage.app',
    measurementId: 'G-PLMKXZT0SH',
  );
}
