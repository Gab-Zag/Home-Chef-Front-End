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
    apiKey: 'AIzaSyB_OQ6ciSMHPmPxtI8Qvek7VNrtZHY8pOY',
    appId: '1:169599650149:web:0914f13d4ba697c556f98c',
    messagingSenderId: '169599650149',
    projectId: 'home-chef-c9111',
    authDomain: 'home-chef-c9111.firebaseapp.com',
    storageBucket: 'home-chef-c9111.firebasestorage.app',
    measurementId: 'G-HDDZJFSZXF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnM9Ca-UYHbNraNoEvPEONaDBXyySBgNI',
    appId: '1:169599650149:android:bd4c109849d48bfb56f98c',
    messagingSenderId: '169599650149',
    projectId: 'home-chef-c9111',
    storageBucket: 'home-chef-c9111.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdZXmrLvPBXhMRPMWgi8s18gB-6jZ4L54',
    appId: '1:169599650149:ios:b53c5ad3968b2fb156f98c',
    messagingSenderId: '169599650149',
    projectId: 'home-chef-c9111',
    storageBucket: 'home-chef-c9111.firebasestorage.app',
    iosBundleId: 'com.example.homeChefFrontEnd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdZXmrLvPBXhMRPMWgi8s18gB-6jZ4L54',
    appId: '1:169599650149:ios:b53c5ad3968b2fb156f98c',
    messagingSenderId: '169599650149',
    projectId: 'home-chef-c9111',
    storageBucket: 'home-chef-c9111.firebasestorage.app',
    iosBundleId: 'com.example.homeChefFrontEnd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_OQ6ciSMHPmPxtI8Qvek7VNrtZHY8pOY',
    appId: '1:169599650149:web:6e8072c2e6184a1156f98c',
    messagingSenderId: '169599650149',
    projectId: 'home-chef-c9111',
    authDomain: 'home-chef-c9111.firebaseapp.com',
    storageBucket: 'home-chef-c9111.firebasestorage.app',
    measurementId: 'G-L0389322HN',
  );
}
