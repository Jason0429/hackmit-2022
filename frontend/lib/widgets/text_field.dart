import 'package:flutter/material.dart';
import 'package:project/utils/styles.dart';

class RecycleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const RecycleTextField({
    super.key,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: StyleConstants.fieldPadding,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: StyleConstants.fieldPadding,
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
