import 'package:flutter/material.dart';
import 'package:project/utils/styles.dart';

class ScreenStarter extends StatelessWidget {
  final Widget _child;

  const ScreenStarter({
    super.key,
    required Widget child,
  }) : _child = child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
      child: Padding(
        padding: StyleConstants.screenPadding,
        child: _child,
      ),
    ));
  }
}
