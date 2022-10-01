import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';

class FirebaseService {
  static Future<void> start() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
