# Flutter Weather & Native Profile App

This Flutter project retrieves weather data and native profile data from an Android system using Jetpack Compose. It follows the **MVVM (Model-View-ViewModel) architecture** and implements **Dependency Injection** using `GetIt`.

## Features
- Fetches **weather data** from OpenWeather API.
- Retrieves **native profile data** from Android using Jetpack Compose.
- Implements **MVVM architecture** for clear separation of concerns.
- Uses **GetIt for Dependency Injection** to manage services.
- Securely loads API keys using **Envied** package.

## Project Architecture
The project follows a clean architecture pattern with a structured folder system:

```
/lib
│── core
│   ├── app_const.dart
│── data
│   ├── model
│   │   ├── weather_model.dart
│   ├── repository
│   │   ├── native_profile_repository.dart
│   │   ├── weather_repository.dart
│── domain
│   ├── usecase
│   │   ├── fetch_native_profile_usecase.dart
│   │   ├── fetch_weather_use_case.dart
│── env
│   ├── env.dart
│   ├── env.g.dart
│── presentation
│   ├── native_profile
│   │   ├── native_profile_tab.dart
│   │   ├── native_profile_view_model.dart
│   ├── weather
│   │   ├── weather_dashboard_tab.dart
│   │   ├── weather_dashboard_view_model.dart
│   ├── home_screen.dart
│── main.dart
│── service_locator.dart
```

### Explanation of Layers
- **Data Layer:** Contains models and repositories for data fetching.
- **Domain Layer:** Contains use cases (business logic) that interact with repositories.
- **Presentation Layer:** Contains UI and ViewModels for state management.
- **Core:** Contains constants and global utilities.
- **Env:** Manages API keys securely with `Envied`.

## 📦 Packages Used
| Package  | Purpose  |
|----------|----------|
| **GetIt**  | Dependency Injection |
| **Envied** | Secure environment variable management (API Keys) |
| **HTTP** | API requests for weather data |


## Dependency Injection (GetIt)
We use **GetIt** to manage dependencies:

```dart
final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<WeatherDataRepository>(() => WeatherDataRepositoryImpl());
  getIt.registerLazySingleton<NativeProfileDataRepository>(() => NativeProfileDataRepositoryImpl());

  getIt.registerLazySingleton<WeatherDashboardUsecase>(
      () => WeatherDashboardUsecase(getIt<WeatherDataRepository>()));

  getIt.registerLazySingleton<FetchNativeProfileDataUseCase>(
      () => FetchNativeProfileDataUseCase(getIt<NativeProfileDataRepository>()));
}
```

## API Key Management (Envied)
API keys are securely stored using `Envied`:

```dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'WEATHER_API_KEY', obfuscate: true)
  static String weatherApiKey = _Env.weatherApiKey;
}
```

## Running the Project
1. **Install Dependencies:**
   ```sh
   flutter pub get
   ```
2. **Generate Env Variables:**
   ```sh
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Run the App:**
   ```sh
   flutter run
   ```

## Conclusion
This project demonstrates a **structured MVVM architecture**, using **clean dependency injection**, **secure API management**, and **proper separation of concerns** for scalable Flutter applications.
