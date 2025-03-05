import 'package:flutter_native/data/repository/pnative_profile_repository.dart';
import 'package:flutter_native/data/repository/weather_repository.dart';
import 'package:flutter_native/domain/usecase/fetch_native_profile_usecase.dart';
import 'package:flutter_native/domain/usecase/fetch_weather_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<WeatherDataRepository>(
      () => WeatherDataRepositoryImpl());
  getIt.registerLazySingleton<NativeProfileDataRepository>(
      () => NativeProfileDataRepositoryImpl());

  getIt.registerLazySingleton<WeatherDashboardUsecase>(
      () => WeatherDashboardUsecase(getIt<WeatherDataRepository>()));

  getIt.registerLazySingleton<FetchNativeProfileDataUseCase>(() =>
      FetchNativeProfileDataUseCase(getIt<NativeProfileDataRepository>()));
}
