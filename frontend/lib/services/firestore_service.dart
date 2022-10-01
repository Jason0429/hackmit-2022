import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<DocumentSnapshot> userSnapshots(String uid) {
    return _firestore.collection("users").doc(uid).snapshots();
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final matches = await _firestore
        .collection("users")
        .where("username", isEqualTo: username.toLowerCase())
        .get();

    return matches.docs.isEmpty;
  }

  static Future<void> createNewUser({
    required String username,
    required String email,
    required User auth,
  }) async {
    debugPrint("Creating new user");
    await _firestore.collection(CollectionName.users.name).doc(auth.uid).set(
          AppUser(
            uid: auth.uid,
            email: email,
            friends: [],
            username: username.toLowerCase(),
            totalRecycledWeight: 0,
          ).toJson(),
          SetOptions(merge: true),
        );
  }
}

enum CollectionName {
  users(name: "users");

  const CollectionName({required this.name});

  final String name;

  @override
  String toString() {
    return name;
  }
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
