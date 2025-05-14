import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDFnWJbuHoHDtTt4UFx1WTCPPK4YCPkNBw",
            authDomain: "mera-pay-5abc3.firebaseapp.com",
            projectId: "mera-pay-5abc3",
            storageBucket: "mera-pay-5abc3.firebasestorage.app",
            messagingSenderId: "369627770815",
            appId: "1:369627770815:web:2b81aa0ba415e22049fb0a",
            measurementId: "G-MN00XJ02WW"));
  } else {
    await Firebase.initializeApp();
  }
}
