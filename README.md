# Flutter App: Weather & Native Profile Data

This Flutter application fetches **weather data** and **native profile data** from Android using **Jetpack Compose** and integrates it into Flutter. The app follows the **MVVM architecture** and utilizes **dependency injection** with GetIt for efficient state management.

## 🏗 Architecture
The project is structured using the **MVVM (Model-View-ViewModel) pattern**, with a clear separation of concerns:

```
📂 lib/
 ├── 📂 data/         # Data layer (repositories, models, API calls)
 │   ├── repository/  # Repository implementations
 │   ├── models/      # Data models
 │   └── sources/     # Remote & local data sources
 │
 ├── 📂 domain/       # Business logic (UseCases)
 │   ├── usecase/     # Contains UseCase classes
 │
 ├── 📂 presentation/ # UI layer (Widgets & ViewModels)
 │   ├── screens/     # Screens (Dashboard, Profile)
 │   ├── viewmodels/  # ViewModels for each screen
 │   └── widgets/     # UI Components
 │
 ├── 📂 core/         # Shared utilities (helpers, services, constants)
 ├── locator.dart     # Dependency injection setup (GetIt)
 ├── main.dart        # App entry point
```

## 📦 Packages Used
| Package  | Purpose  |
|----------|----------|
| **GetIt**  | Dependency Injection |
| **Envied** | Secure environment variable management (API Keys) |
| **HTTP** | API requests for weather data |

## 🔗 Dependency Injection (GetIt)
The app uses **GetIt** to manage dependencies efficiently. Services and repositories are registered in `locator.dart`:

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

## 🌎 Environment Variables (API Keys)
The **Envied** package is used to securely manage API keys.

1. Create a `.env` file in the root directory:
   ```plaintext
   WEATHER_API_KEY=your_api_key_here
   ```
2. Create an `env.dart` file:
   ```dart
   import 'package:envied/envied.dart';
   
   part 'env.g.dart';
   
   @Envied()
   abstract class Env {
     @EnviedField(varName: 'WEATHER_API_KEY')
     static const String weatherApiKey = _Env.weatherApiKey;
   }
   ```
3. Run `flutter pub run build_runner build` to generate the secure file.

## 📡 Fetching Weather & Native Profile Data
- **Weather Data**: Retrieved using OpenWeather API.
- **Native Profile Data**: Fetched from Android (Jetpack Compose) via MethodChannel.

This project efficiently bridges **native Android profile data** with Flutter while providing **weather updates** in an optimized and scalable manner. 🚀
