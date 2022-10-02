import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/services/snackbar_service.dart';
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
      SnackbarService.showSnackbar(
        text: "Signed in successfully",
        backgroundColor: Colors.green,
      );
      NavigationService.pushReplacementNamed(RouteNames.main);
      return;
    }

    String err = _getLoginErrMessage(loginErrMsg);

    debugPrint("Login error: $err");

    SnackbarService.showSnackbar(
      text: err,
      backgroundColor: Colors.redAccent,
    );
  }

  String _getLoginErrMessage(String errCode) {
    switch (errCode) {
      case "invalid-email":
        return "Email address is not valid";
      case "user-disabled":
        return "The user corresponding to the given email has been disabled.";
      case "user-not-found":
        return "There is no user corresponding to the given email.";
      case "wrong-password":
        return "Password is invalid for the given email.";
      default:
        return "Something went wrong.";
    }
  }
}
