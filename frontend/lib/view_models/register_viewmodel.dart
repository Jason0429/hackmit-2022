import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/services/snackbar_service.dart';
import 'package:project/utils/routes.dart';

class RegisterViewModel {
  Future<bool> isUsernameAvailable(String username) async {
    if (username.isEmpty) {
      return false;
    }

    return await FirestoreService.isUsernameAvailable(username);
  }

  String? validateConfirmPassword(String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Password cannot be empty";
    }
    if (confirmPassword != password) {
      return "Passwords must match";
    }
    return null;
  }

  Future<void> handleRegister(
      String username, String email, String password) async {
    debugPrint("Register: $email, $password");

    final registerErrorMsg =
        await AuthService.registerWithEmailAndPassword(email, password);

    /// If successful registration:
    if (registerErrorMsg == null) {
      final auth = AuthService.currentUser;

      if (auth == null) {
        throw Exception("Auth user is null");
      }

      await FirestoreService.createNewUser(
        username: username,
        email: email,
        auth: auth,
      );

      NavigationService.pushReplacementNamed(RouteNames.main);

      return;
    }

    // If registration failed
    String err = _getRegisterErrorMessage(registerErrorMsg);

    debugPrint("Register error: $err");

    SnackbarService.showSnackbar(
      text: err,
      backgroundColor: Colors.redAccent,
    );
  }

  String _getRegisterErrorMessage(String errCode) {
    switch (errCode) {
      case "email-already-in-use":
        return "There already exists an account with the given email address.";
      case "invalid-email":
        return "Email address is not valid.";
      case "operation-not-allowed":
        return "Email/Password accounts are not enabled. Please contact administrator.";
      case "weak-password":
        return "Password is not strong enough.";
      default:
        return "Something went wrong.";
    }
  }
}
