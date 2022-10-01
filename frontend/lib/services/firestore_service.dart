import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<DocumentSnapshot> userSnapshots(String uid) {
    return _firestore.collection("users").doc(uid).snapshots();
  }

  // static Stream<Iterable<Lesson>> get lessonsSnapshots => _firestore
  //     .collection("lessons")
  //     .orderBy("lessonIndex")
  //     .snapshots()
  //     .map((q) => q.docs.map((doc) {
  //           final data = doc.data();
  //           return Lesson(
  //             id: doc.id,
  //             image: data['image'],
  //             backgroundColor: data['backgroundColor'],
  //             lessonIndex: data['lessonIndex'],
  //             title: data['title'],
  //             quizCount: data['quizCount'],
  //           );
  //         }));
}
