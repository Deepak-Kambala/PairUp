import 'package:flutter/material.dart';

import 'package:pairup/screens/matches_screen.dart';
import 'package:pairup/screens/home_screen.dart';
import 'package:pairup/screens/profile_screen.dart';
import 'package:pairup/screens/notifications_screen.dart';
import 'package:pairup/screens/create_screen.dart';
import 'package:pairup/widget/custom_bottom_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  final int startIndex;
  final String? firstName;
  final String? lastName;
  final List<String>? skills;

  const MainWrapper({
    super.key,
    this.startIndex = 0,
    this.firstName,
    this.lastName,
    this.skills,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;

    _screens = [
      const HomeScreen(),
      const MatchesScreen(),
      const CreateScreen(),
      const NotificationsScreen(),
      ProfileScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
        skills: widget.skills,
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
