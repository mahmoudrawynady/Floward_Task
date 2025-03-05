library weather_lib;

import 'package:flutter/widgets.dart';
import 'package:flutter_native/core/app_const.dart';
import 'package:flutter_native/data/model/weather_model.dart';
import 'package:flutter_native/domain/usecase/fetch_weather_use_case.dart';
import 'package:flutter_native/service_locator.dart';

part 'weather_dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _WeatherDashboardViewModel _weatherDashboardViewModel =
      _WeatherDashboardViewModel();

  @override
  void initState() {
    _weatherDashboardViewModel.fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<WeatherModel?>(
        valueListenable: _weatherDashboardViewModel.weatherDataNotifier,
        builder: (context, weather, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Constants.city,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(weather?.temperature ?? '',
                  style: const TextStyle(fontSize: 30)),
              Text(weather?.condition ?? '',
                  style: const TextStyle(fontSize: 20)),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _weatherDashboardViewModel.weatherDataNotifier.dispose();
    super.dispose();
  }
}
