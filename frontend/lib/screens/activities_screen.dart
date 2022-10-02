import 'package:flutter/material.dart';
import 'package:project/models/activity.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/screen_title.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = AuthService.currentUser!.uid;
    debugPrint("uid: $uid");

    return StreamBuilder<Iterable<Activity>>(
        stream: FirestoreService.activitiesStream(uid),
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
                ScreenTitle("Activities"),
                ...data
                    .map((a) => Row(children: [
                          Text(a.itemName),
                          const SizedBox(width: 20),
                          Text(a.category),
                        ]))
                    .toList(),
              ],
            ),
          );
        });
  }
}
