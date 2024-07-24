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
      apiKey: "AIzaSyAAb4zh97aGgodOqT-mzbAVkJl0xGIuLv8",
      authDomain: "health-9ccb5.firebaseapp.com",
      projectId: "health-9ccb5",
      storageBucket: "health-9ccb5.appspot.com",
      messagingSenderId: "681313781092",
      appId: "1:681313781092:web:f883b19048d069726be671",
      measurementId: "G-3D0BVYTMZH");

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyA6PWiHMXlbw4qHWijvuhv3gY-LeL72IsE',
      appId: '1:681313781092:android:7a6ee042f58d3c1c6be671',
      messagingSenderId: '681313781092',
      projectId: 'health-9ccb5',
      storageBucket: 'health-9ccb5.appspot.com');

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpAIdPcpOR7Oc7ZRM81yuB8hA1UHST9hI',
    appId: '1:681313781092:ios:618d90100b62d41d6be671',
    messagingSenderId: '681313781092',
    projectId: 'health-9ccb5',
    storageBucket: 'health-9ccb5.appspot.com',
    iosClientId:
        '681313781092-6kdqrbci378840u6h84cprukdahs10cp.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthEClub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpAIdPcpOR7Oc7ZRM81yuB8hA1UHST9hI',
    appId: '1:681313781092:ios:618d90100b62d41d6be671',
    messagingSenderId: '681313781092',
    projectId: 'health-9ccb5',
    storageBucket: 'health-9ccb5.appspot.com',
    iosClientId:
        '681313781092-6kdqrbci378840u6h84cprukdahs10cp.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthEClub',
  );
}
