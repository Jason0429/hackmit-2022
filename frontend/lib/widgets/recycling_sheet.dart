import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/widgets/screen_starter.dart';

class RecyclingSheet extends StatelessWidget {
  const RecyclingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenStarter(
        child: Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _ExitButton(),
        ),
        Text("Hi"),
        Text("Hi"),
        Text("Hi"),
        Text("Hi"),
        Text("Hi"),
      ],
    ));
  }
}

class _ExitButton extends StatelessWidget {
  const _ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.expand_more_outlined),
      onPressed: () {},
    );
  }
}
