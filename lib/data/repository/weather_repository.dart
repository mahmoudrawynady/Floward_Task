import 'dart:convert';
import 'package:flutter_native/core/app_const.dart';
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
        '${Constants.weatherBaseUrl}?q=${Constants.city}&appid=${Env.API_KEY}&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
