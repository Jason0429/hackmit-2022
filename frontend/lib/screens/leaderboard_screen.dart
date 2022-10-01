import 'package:flutter/material.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/screen_title.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenStarter(
      child: ListView(
        children: [
          ScreenTitle("Leaderboard"),
        ],
      ),
    );
  }
}
