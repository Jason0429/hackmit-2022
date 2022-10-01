import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_disrupt_app/firebase_options.dart';

class FirebaseService {
  static Future<void> start() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
