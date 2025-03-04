import 'dart:convert';
import 'package:flutter_native/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherDataRepository {
  Future<WeatherModel> fetchWeather();
}

class WeatherDataRepositoryImpl implements WeatherDataRepository {
  @override
  Future<WeatherModel> fetchWeather() async {
    const apiKey = '3bd31af6479d85b7640c1def596eb88b';
    const url =
        'https://api.openweathermap.org/data/2.5/weather?q=Cairo&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
