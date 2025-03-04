import 'package:flutter_native/data/model/weather_model.dart';
import 'package:flutter_native/data/remote/weather_repository.dart';
import 'package:flutter_native/presentation/home_screen.dart';

class WeatherDashboardUsecase {
  final WeatherDataRepository repository;

  WeatherDashboardUsecase(this.repository);

  Future<WeatherModel> execute() async {
    return await repository.fetchWeather();
  }
}
