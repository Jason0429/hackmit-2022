import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/services/snackbar_service.dart';
import 'package:project/types/extensions/string.dart';
import 'package:project/utils/routes.dart';

class LoginViewModel {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !EmailValidator.validate(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  void validateThen(GlobalKey<FormState> formKey, Function callback) {
    if (!formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      return;
    }

    // Handle login process
    callback();
  }

  Future<void> handleLogin(String email, String password) async {
    debugPrint("Login: $email, $password");

    final loginErrMsg =
        await AuthService.signInWithEmailAndPassword(email, password);

    if (loginErrMsg == null) {
      NavigationService.pushReplacementNamed(RouteNames.main);
      return;
    }

    String err = "";

    switch (loginErrMsg) {
      case "invalid-email":
        err = "Email address is not valid";
        break;
      case "user-disabled":
        err = "The user corresponding to the given email has been disabled.";
        break;
      case "user-not-found":
        err = "There is no user corresponding to the given email.";
        break;
      case "wrong-password":
        err = "Password is invalid for the given email.";
        break;
      default:
        err = "Something went wrong.";
        break;
    }

    debugPrint("Login error: $err");

    SnackbarService.showSnackbar(
      text: err,
      backgroundColor: Colors.redAccent,
    );
  }
}
