import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/services/snackbar_service.dart';
import 'package:project/utils/routes.dart';

class ProfileController {
  Future<void> handleLogoutButton() async {
    await AuthService.signOut();
    SnackbarService.showSnackbar(
      text: "Logged out successfully",
      backgroundColor: Colors.green,
    );
    NavigationService.pushReplacementNamed(RouteNames.login);
  }
}
