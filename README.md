# Flutter Weather & Native Profile App

This Flutter project retrieves weather data and native profile data from an Android system using Jetpack Compose. It follows the **MVVM (Model-View-ViewModel) architecture** and implements **Dependency Injection** using `GetIt`.

## Tech Stack
- **Flutter**: 3.24.5
- **Dart**: 3.5.4
- **State Management**: MVVM Pattern with ValueNotifier
- **Dependency Injection**: GetIt
- **Environment Variables**: Envied
- **Networking**: HTTP

## Features
- Fetches weather data using OpenWeather API
- Retrieves native profile data from Android using Jetpack Compose
- Implements MVVM architecture
- Uses Dependency Injection with GetIt
- Manages API keys securely with Envied
- Implements modular imports using `library`, `part`, and `part of` directives
- Secret environment variables are ignored from Git for security

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


## Dependency Injection
This project uses **GetIt** for Dependency Injection. Services and use cases are registered in `service_locator.dart`:

```dart
final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<WeatherDataRepository>(() => WeatherDataRepositoryImpl());
  getIt.registerLazySingleton<NativeProfileDataRepository>(() => NativeProfileDataRepositoryImpl());
  getIt.registerLazySingleton<WeatherDashboardUsecase>(() => WeatherDashboardUsecase(getIt<WeatherDataRepository>()));
  getIt.registerLazySingleton<FetchNativeProfileDataUseCase>(() => FetchNativeProfileDataUseCase(getIt<NativeProfileDataRepository>()));
}
```


## Native Profile Data Handling
The native profile data is retrieved in **MainActivity** using the `getProfile` method. This method sends static profile data, including the name, email, and profile picture path, from Android (using Jetpack Compose) to Flutter via a MethodChannel:

```kotlin
class MainActivity : FlutterActivity() {
    private val CHANNEL = "native_profile_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getProfile" -> {
                    val profile = JSONObject()
                    profile.put("name", "John Doe")
                    profile.put("email", "john.doe@example.com")
                    val profileImagePath = saveProfileImageToInternalStorage(this)
                    profile.put("profile_picture", profileImagePath)
                    result.success(profile.toString())
                }
                else -> result.notImplemented()
            }
        }
    }

    fun saveProfileImageToInternalStorage(context: Context): String {
        val bitmap = BitmapFactory.decodeResource(context.resources, R.drawable.profile_picture)
        val file = File(context.filesDir, "profile_picture.jpg")
        
        FileOutputStream(file).use { fos ->
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos)
        }

        return file.absolutePath
    }
}
```

## API Key Management
The project uses **Envied** to securely manage API keys. The weather API key is stored in `.env` and accessed via `env.dart`:

```dart
@Envied()
abstract class Env {
  @EnviedField(varName: 'WEATHER_API_KEY', obfuscate: true)
  static String weatherApiKey = _Env.weatherApiKey;
}
```

### Ignoring Secret Files
The `.env` and generated `env.g.dart` files are ignored from Git using `.gitignore` to prevent exposing sensitive information.

## Modular Imports
This project follows a modular approach using **library**, **part**, and **part of** directives to split the code efficiently across different files. This ensures better maintainability and avoids circular dependencies.

## Running the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo.git
   cd your-repo
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. The API key already added to `.env` file, you can replace it with your own key using the line below bu no need:
   ```sh
   API_KEY=your_api_key_here
   ```
4. Generate the env file:
   ```sh
   dart run build_runner clean
   dart run build_runner build --delete-conflicting-outputs
   or 
   dart run build_runner build --define=envied_generator:envied=path=my_other.env
   ```
5. Run the project:
   ```sh
   flutter run
   ```


---
**Author**: 
- Mahmoud Rawy
- Mahmoudrawy96@gmail.com

Feel free to contribute and improve this project! 🚀
