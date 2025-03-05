# Flutter Weather App

## Overview
This is a Flutter application that follows the **MVVM (Model-View-ViewModel) architecture** and implements **dependency injection** using GetIt. The app fetches weather data using the OpenWeather API and displays it on a dashboard.

## Project Structure
The project follows a structured folder hierarchy:

```
/lib
│── main.dart  # Application entry point
│
├── core       # Core utilities and shared classes
│
├── data       # Data layer (Repositories, Models, API handling)
│   ├── models       # Data models
│   ├── repositories # Repository implementations
│   ├── sources      # Remote and local data sources
│
├── domain     # Business logic layer (Use cases, Interfaces)
│   ├── entities    # Business models
│   ├── repositories # Abstract repository contracts
│   ├── usecases     # Business logic for fetching data
│
├── presentation # UI layer (MVVM - Views, ViewModels, Widgets)
│   ├── screens   # Screens for the app
│   ├── viewmodels # State management using ChangeNotifier
│   ├── widgets    # Reusable UI components
│
├── di          # Dependency Injection setup using GetIt
│   ├── locator.dart # Service locator for dependency injection
```

## Packages Used

| Package    | Purpose |
|------------|---------|
| **get_it** | Dependency injection for managing instances |
| **envied** | Securely store and access API keys |
| **http**   | HTTP client for API requests |
| **intl**   | Date formatting and localization |

## Dependency Injection
We use **GetIt** for dependency injection. Services and repositories are registered inside `locator.dart`:

```dart
import 'package:get_it/get_it.dart';
import '../data/repositories/weather_repository.dart';
import '../domain/usecases/weather_usecase.dart';
import '../presentation/viewmodels/weather_viewmodel.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl());
  getIt.registerFactory(() => WeatherUsecase(getIt<WeatherRepository>()));
  getIt.registerFactory(() => WeatherViewModel(getIt<WeatherUsecase>()));
}
```

## MVVM Implementation
Each screen follows the **MVVM pattern**:

1. **Model (Domain layer)**: Defines entities like `WeatherModel`.
2. **ViewModel (Presentation layer)**: Handles state and business logic.
3. **View (UI layer)**: Displays UI and listens to ViewModel changes.

Example **WeatherViewModel**:

```dart
import 'package:flutter/material.dart';
import '../../domain/usecases/weather_usecase.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherUsecase _weatherUsecase;
  String temperature = "Loading...";
  String condition = "";

  WeatherViewModel(this._weatherUsecase);

  Future<void> fetchWeather() async {
    final weather = await _weatherUsecase.execute();
    temperature = "${weather.temp}°C";
    condition = weather.description;
    notifyListeners();
  }
}
```

## Environment Variables
We use the **envied** package to manage API keys securely. Add your API key in a `.env` file:

```
WEATHER_API_KEY=your_api_key_here
```

Run the following command to generate the necessary Dart file:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Running the Project

1. Clone the repository:
   ```sh
   git clone https://github.com/mahmoudrawynady/Floward_Task.git
   ```
2. Navigate to the project directory:
   ```sh
   cd Floward_Task
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Setup environment variables (`.env` file as men