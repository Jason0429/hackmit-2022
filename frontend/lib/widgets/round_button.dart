import 'package:flutter/material.dart';
import 'package:project/utils/theme.dart';

class RecycleButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const RecycleButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: DisruptTheme.FONT_SIZE_LARGE,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
