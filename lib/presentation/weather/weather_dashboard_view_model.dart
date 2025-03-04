part of weather_lib;

class _WeatherDashboardViewModel {
  _WeatherDashboardViewModel();

  final ValueNotifier<WeatherModel> weatherDataNotifier =
      ValueNotifier(WeatherModel(temperature: "Loading...", condition: ""));

  Future<void> fetchWeather() async {
    final weatherData = await getIt<WeatherDashboardUsecase>().execute();
    weatherDataNotifier.value = weatherData;
  }
}
