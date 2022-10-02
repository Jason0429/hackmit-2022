import 'package:flutter/material.dart';
import 'package:project/screens/activities_screen.dart';
import 'package:project/screens/camera_screen_1.dart';
import 'package:project/screens/leaderboard_screen.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:camera/camera.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  final _items = _BottomTabs.tabs.map((i) => i.keys.first).toList();
  final _screens = _BottomTabs.tabs.map((i) => i.values.first).toList();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onTabTapped,
          backgroundColor: Colors.blueGrey[900],
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class _BottomTabs {
  static const _iconSize = 20.0;
  static final tabs = [
    {
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          size: _iconSize,
        ),
        label: 'Profile',
      ): ProfileScreen(),
    },
    {
      BottomNavigationBarItem(
        icon: Icon(
          Icons.camera_alt,
          size: _iconSize,
        ),
        label: 'Camera',
      ): CameraPromptScreen(),
    },
    {
      BottomNavigationBarItem(
        icon: Icon(
          Icons.list,
          size: _iconSize,
        ),
        label: 'Activities',
      ): ActivitiesScreen(),
    },
    {
      BottomNavigationBarItem(
        icon: Icon(
          Icons.leaderboard,
          size: _iconSize,
        ),
        label: 'Leaderboard',
      ): LeaderboardScreen(),
    },
  ];
}
