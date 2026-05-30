// Values from android/app/google-services.json (project: vehicleverify-f6ca8)

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web is not configured for this app.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('iOS is not configured.');
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNGY8sI-NZfzyiKNpxCEldh_rqLxCr0hE',
    appId: '1:662396659379:android:4ad2ac0903ca1058bc72c6',
    messagingSenderId: '662396659379',
    projectId: 'vehicleverify-f6ca8',
    storageBucket: 'vehicleverify-f6ca8.firebasestorage.app',
  );
}
