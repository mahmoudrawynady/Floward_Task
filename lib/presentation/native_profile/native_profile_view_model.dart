part of native_profile_lib;

class _NativeProfileViewModel {
  ValueNotifier<Map<String, dynamic>?> profileNativeDataNotifier =
      ValueNotifier(null);

  Future<void> fetchWeather() async {
    try {
      final nativeProfileData =
          await getIt<FetchNativeProfileDataUseCase>().execute();
      profileNativeDataNotifier.value = nativeProfileData;
    } on PlatformException catch (e) {
      debugPrint('Failed to get profile data: ${e.message}');
    }
  }
}
