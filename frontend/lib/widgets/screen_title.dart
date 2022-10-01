import 'package:flutter/material.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/styles.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Image(
            image: AssetImage(ImagePaths.recycleLogo),
            height: StyleConstants.titleFontSize,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: StyleConstants.titleFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
