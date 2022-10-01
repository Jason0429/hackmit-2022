import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/services/snackbar_service.dart';
import 'package:project/utils/routes.dart';

class RegisterViewModel {
  String? validateConfirmPassword(String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Password cannot be empty";
    }
    if (confirmPassword != password) {
      return "Passwords must match";
    }
    return null;
  }

  Future<void> handleRegister(String email, String password) async {
    debugPrint("Register: $email, $password");

    final registerErrorMsg =
        await AuthService.registerWithEmailAndPassword(email, password);

    if (registerErrorMsg == null) {
      NavigationService.pushReplacementNamed(RouteNames.main);
      return;
    }

    String err;

    switch (registerErrorMsg) {
      case "email-already-in-use":
        err = "There already exists an account with the given email address.";
        break;
      case "invalid-email":
        err = "Email address is not valid.";
        break;
      case "operation-not-allowed":
        err =
            "Email/Password accounts are not enabled. Please contact administrator.";
        break;
      case "weak-password":
        err = "Password is not strong enough.";
        break;
      default:
        err = "Something went wrong.";
        break;
    }

    debugPrint("Register error: $err");

    SnackbarService.showSnackbar(
      text: err,
      backgroundColor: Colors.redAccent,
    );
  }
}
