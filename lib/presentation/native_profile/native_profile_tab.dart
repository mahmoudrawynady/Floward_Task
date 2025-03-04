library native_profile_lib;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native/domain/usecase/fetch_native_profile_usecase.dart';
import 'package:flutter_native/service_locator.dart';

part 'native_profile_view_model.dart';

class NativeProfileScreen extends StatefulWidget {
  const NativeProfileScreen();

  @override
  State<NativeProfileScreen> createState() => _NativeProfileScreenState();
}

class _NativeProfileScreenState extends State<NativeProfileScreen> {
  final _NativeProfileViewModel _nativeProfileDateVieWModel =
      _NativeProfileViewModel();

  @override
  void initState() {
    _nativeProfileDateVieWModel.fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: _nativeProfileDateVieWModel.profileNativeDataNotifier,
      builder: (context, profileData, child) {
        if (profileData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    FileImage(File(profileData['profile_picture'])),
              ),
              const SizedBox(height: 16),
              Text("Name: ${profileData['name']}",
                  style: const TextStyle(fontSize: 24)),
              Text("Email: ${profileData['email']}",
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }
}
