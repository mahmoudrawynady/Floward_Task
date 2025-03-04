import 'package:flutter_native/data/remote/weather_repository.dart';
import 'package:flutter_native/domain/usecase/fetch_weather_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance; // Correct instance of GetIt

void setupLocator() {
  getIt.registerLazySingleton<WeatherDataRepository>(() => WeatherDataRepositoryImpl());

  getIt.registerLazySingleton<WeatherDashboardUsecase>(
        () => WeatherDashboardUsecase(getIt<WeatherDataRepository>()),
  );
}