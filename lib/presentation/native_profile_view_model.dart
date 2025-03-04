part of home_lib;

class _NativeProfileViewModel {
  ValueNotifier<Map<String, dynamic>?> profileDataNotifier =
      ValueNotifier(null);

  Future<void> fetchWeather() async {
    try {
      final nativeProfileData =
          await getIt<FetchNativeProfileDataUseCase>().execute();
      profileDataNotifier.value = nativeProfileData;
    } on PlatformException catch (e) {
      debugPrint('Failed to get profile data: ${e.message}');
    }
  }
}
