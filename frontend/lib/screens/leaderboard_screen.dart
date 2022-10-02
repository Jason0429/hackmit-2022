import 'package:flutter/material.dart';
import 'package:project/models/app_user.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/screen_title.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<AppUser>>(
        stream: FirestoreService.usersStream(),
        builder: (_, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return ScreenStarter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return ScreenStarter(
            child: ListView(
              children: [
                ScreenTitle("Leaderboard"),
                ...data.map(
                  (u) => Row(
                    children: [
                      Text("Username: ${u.username}"),
                      Text("Total Items Recycled: ${u.totalItemsRecycled}"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
