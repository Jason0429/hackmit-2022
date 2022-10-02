import 'package:flutter/material.dart';
import 'package:project/screens/activities_screen.dart';
import 'package:project/screens/camera_screen_1.dart';
import 'package:project/screens/leaderboard_screen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/screens/main_screen.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:project/screens/register_screen.dart';
import 'package:project/view_models/camera_viewmodel.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.login: (_) => LoginScreen(),
    RouteNames.register: (_) => RegisterScreen(),
    RouteNames.main: (_) => MainScreen(),
    RouteNames.profile: (_) => ProfileScreen(),
    RouteNames.activites: (_) => ActivitiesScreen(),
    RouteNames.camera: (_) => CameraPromptScreen(),
    RouteNames.leaderboard: (_) => LeaderboardScreen(),
  };
}

class RouteNames {
  static const login = "log_in";
  static const register = "register";
  static const main = "main";
  static const profile = "profile";
  static const activites = "activities";
  static const leaderboard = "leaderboard";
  static const camera = "camera";
}
