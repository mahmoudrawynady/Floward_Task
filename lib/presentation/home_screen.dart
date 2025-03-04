library home_lib;

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native/data/model/weather_model.dart';
import 'package:flutter_native/domain/usecase/fetch_weather_use_case.dart';
import 'package:flutter_native/service_locator.dart';
part 'native_profile_tab.dart';
part 'weather_dashboard_tab.dart';
part 'weather_dashboard_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('native_profile_channel');

  // Using ValueNotifier for selected index
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  // Using ValueNotifier for profile data
  final ValueNotifier<Map<String, dynamic>?> profileDataNotifier =
      ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _getProfileDataFromNative();
  }

  Future<void> _getProfileDataFromNative() async {
    try {
      final String result = await platform.invokeMethod('getProfile');
      profileDataNotifier.value = json.decode(result);
    } on PlatformException catch (e) {
      debugPrint('Failed to get profile data: ${e.message}');
    }
  }

  void _onItemTapped(int index) {
    selectedIndexNotifier.value = index;
    if (index == 1) {
      _getProfileDataFromNative();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return selectedIndex == 0
              ? const _DashboardScreen()
              : _NativeProfileScreen(profileDataNotifier: profileDataNotifier);
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}
