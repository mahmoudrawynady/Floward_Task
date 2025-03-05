library home_lib;

import 'package:flutter/material.dart';
import 'package:flutter_native/core/app_const.dart';
import 'package:flutter_native/presentation/native_profile/native_profile_tab.dart';
import 'package:flutter_native/presentation/weather/weather_dashboard_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Using ValueNotifier for selected index
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

  // Using ValueNotifier for profile data
  final ValueNotifier<Map<String, dynamic>?> profileDataNotifier =
      ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    _selectedIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return selectedIndex == 0
              ? const DashboardScreen()
              : const NativeProfileScreen();
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label:Constants.dashboard ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: Constants.profile),
            ],
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}
