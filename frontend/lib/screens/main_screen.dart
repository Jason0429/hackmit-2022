import 'package:flutter/material.dart';
import 'package:project/screens/activities_screen.dart';
import 'package:project/screens/camera_screen.dart';
import 'package:project/screens/leaderboard_screen.dart';
import 'package:project/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabScreens = [
    ProfileScreen(),
    CameraScreen(),
    ActivitiesScreen(),
    LeaderboardScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabScreens.length,
      child: Scaffold(
        body: _tabScreens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _BottomNavigationBarItems.items,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onTabTapped,
          // backgroundColor: const Color(0xFF121f1f),
          backgroundColor: Colors.blueGrey[900],
          elevation: 0,
        ),
      ),
    );
  }
}

class _BottomNavigationBarItems {
  static const _iconSize = 20.0;
  static const items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: _iconSize,
      ),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.menu_book,
        size: _iconSize,
      ),
      label: 'Lessons',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.event,
        size: _iconSize,
      ),
      label: 'Events',
    ),
  ];
}
