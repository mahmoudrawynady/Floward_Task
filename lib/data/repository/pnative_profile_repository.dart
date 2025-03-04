import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract class NativeProfileDataRepository {
  Future<Map<String, dynamic>?> getProfileDataFromNative();
}

class NativeProfileDataRepositoryImpl implements NativeProfileDataRepository {
  static const _platform = MethodChannel('native_profile_channel');

  @override
  Future<Map<String, dynamic>?> getProfileDataFromNative() async {
    try {
      final String result = await _platform.invokeMethod('getProfile');
      return json.decode(result);
    } on PlatformException catch (e) {
      debugPrint('Failed to get profile data: ${e.message}');
      return null;
    }
  }
}
