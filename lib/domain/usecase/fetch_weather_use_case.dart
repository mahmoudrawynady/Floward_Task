import 'package:flutter_native/data/model/weather_model.dart';
import 'package:flutter_native/data/repository/weather_repository.dart';

class WeatherDashboardUsecase {
  final WeatherDataRepository repository;

  WeatherDashboardUsecase(this.repository);

  Future<WeatherModel> execute() async {
    return await repository.fetchWeather();
  }
}
