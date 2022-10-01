import 'package:flutter/material.dart';
import 'package:project/utils/constants.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKeys.scaffoldMessengerKey;

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  static void showSnackbar({
    required String text,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
      duration: duration,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }
}
