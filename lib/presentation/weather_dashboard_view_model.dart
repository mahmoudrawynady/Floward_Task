part of home_lib;

class _WeatherDashboardViewModel {
  _WeatherDashboardViewModel();

  final ValueNotifier<WeatherModel> weatherNotifier =
      ValueNotifier(WeatherModel(temperature: "Loading...", condition: ""));

  Future<void> fetchWeather() async {
    final weatherData = await getIt<WeatherDashboardUsecase>().execute();
    weatherNotifier.value = weatherData;
  }
}
