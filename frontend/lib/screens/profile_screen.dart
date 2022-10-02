import 'package:flutter/material.dart';
import 'package:project/models/app_user.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/view_models/profile_controller.dart';
import 'package:project/widgets/round_button.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/screen_title.dart';

class ProfileScreen extends StatelessWidget {
  final controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    final uid = AuthService.currentUser!.uid;
    debugPrint("uid: $uid");

    return StreamBuilder(
        stream: FirestoreService.userStream(uid),
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
                ScreenTitle("Profile"),
                Text("Username: ${data.username}"),
                Text("Email: ${data.email}"),
                Text("Friends: ${data.friends.length}"),
                Text("Total Items Recycled: ${data.totalItemsRecycled}"),
                RecycleButton(
                  onPressed: controller.handleLogoutButton,
                  text: "Log out",
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        });
  }
}
