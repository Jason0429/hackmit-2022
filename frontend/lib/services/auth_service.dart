import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  static final _auth = FirebaseAuth.instance;

  static User? user;

  static FirebaseAuth get auth => _auth;

  static User? get currentUser => _auth.currentUser;

  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  AuthService() {
    _auth.authStateChanges().listen((state) {
      user = state;
      notifyListeners();
    });
  }

  /// Authenticates user via email and password.
  /// Returns error if something went wrong.
  static Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint("Signed in as $email");
      return null;
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

  /// Registers user with email and password.
  /// Returns error if something went wrong.
  static Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;

      debugPrint("Registered as: $email");

      await user?.sendEmailVerification();

      debugPrint("Sent email verification to: ${user?.email}");

      return null;
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

  /// Sends password reset email.
  static Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  /// Signs out.
  /// Returns error if something went wrong.
  static Future<String?> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("Signed out");
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
