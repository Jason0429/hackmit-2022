import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

import '../models/app_user.dart';

class FirestoreService with ChangeNotifier {
  static final _firestore = FirebaseFirestore.instance;
  // static AppUser? user;

  static Stream<AppUser> userStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((d) => AppUser.fromJson(d.data()!));
  }

  // Future<FirestoreService> updateUser() async {
  //   final auth = AuthService.currentUser;

  //   if (auth == null) {
  //     user = null;
  //   } else {
  //     final doc = await _firestore.collection("users").doc(auth.uid).get();
  //     final userData = doc.data();

  //     if (userData == null) {
  //       user = null;
  //     } else {
  //       user = AppUser.fromJson(userData);
  //     }
  //   }

  //   notifyListeners();
  //   return this;
  // }

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
            totalItemsRecycled: 0,
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
