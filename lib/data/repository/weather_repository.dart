import 'dart:convert';
import 'package:flutter_native/data/model/weather_model.dart';
import 'package:flutter_native/env/env.dart';
import 'package:http/http.dart' as http;

abstract class WeatherDataRepository {
  Future<WeatherModel> fetchWeather();
}

class WeatherDataRepositoryImpl implements WeatherDataRepository {
  @override
  Future<WeatherModel> fetchWeather() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=Cairo&appid=${Env.API_KEY}&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
