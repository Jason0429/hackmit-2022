import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/activity.dart';

import '../models/app_user.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  // static Future<AppUser> user(String uid) async {
  //   final doc = await _firestore.collection("users").doc(uid).get();
  //   return AppUser.fromJson(doc.data()!);
  // }

  static Stream<AppUser> userStream(String uid) =>
      _firestore.collection("users").doc(uid).snapshots().map((d) {
        final data = d.data();

        if (data == null) {
          throw Exception("User is not in firestore");
        }

        return AppUser.fromJson(data);
      });

  static Stream<Iterable<AppUser>> usersStream() => _firestore
      .collection("users")
      .orderBy("totalItemsRecycled", descending: true)
      .snapshots()
      .map((q) => q.docs.map((d) => AppUser.fromJson(d.data())));

  static Stream<Iterable<Activity>> activitiesStream(String uid) => _firestore
      .collection("users/$uid/activities")
      .orderBy("createdOn", descending: true)
      .snapshots()
      .map((q) => q.docs.map((d) => Activity.fromJson(d.data())));

  /// Add activity to recents
  static Future<void> addActivity(String uid, Activity activity) async {
    final prev = await _firestore.collection("users").doc(uid).get();
    final prevUser = AppUser.fromJson(prev.data()!);
    await _firestore
        .collection("users")
        .doc(uid)
        .update({'totalItemsRecycled': prevUser.totalItemsRecycled + 1});
    await _firestore.collection("users/$uid/activities").doc(activity.id).set(
          activity.toJson(),
          SetOptions(merge: true),
        );
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
