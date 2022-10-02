import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/view_models/profile_controller.dart';
import 'package:project/widgets/round_button.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/screen_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController();

    return ScreenStarter(
      child: StreamBuilder(
          stream: FirestoreService.userStream(AuthService.currentUser!.uid),
          builder: (_, snapshot) {
            // if (!snapshot.hasData) {
            //   return CircularProgressIndicator();
            // }
            return ListView(
              children: [
                ScreenTitle("Profile"),
                RecycleButton(
                  onPressed: controller.handleLogoutButton,
                  text: "Log out",
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white,
                ),
              ],
            );
          }),
    );
  }
}
