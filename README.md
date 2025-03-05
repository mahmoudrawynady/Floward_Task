# Weather App

A Flutter application that fetches weather data and displays it using clean architecture principles.

## 📁 Project Structure
The project follows a clean architecture pattern with three main layers:

- **Data Layer**: Handles API calls and data sources.
- **Domain Layer**: Contains business logic and use cases.
- **Presentation Layer**: Manages UI and state.

```
lib/
│── data/           # Data layer (API calls, repositories)
│── domain/         # Domain layer (business logic, use cases)
│── presentation/   # UI layer (screens, widgets)
│── main.dart       # Entry point
```

## 🛠 Packages Used
- **[GetIt](https://pub.dev/packages/get_it)** - Dependency Injection
- **[Envied](https://pub.dev/packages/envied)** - Environment variables management
- **[HTTP](https://pub.dev/packages/http)** - API requests

## 🔧 Setup Instructions
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
4. Create a `.env` file for API keys:
   ```sh
   touch .env
   ```
   Add the following:
   ```sh
   WEATHER_API_KEY=your_api_key_here
   ```
5. Run the app:
   ```sh
   flutter run
   ```

## 🏗 Architecture Details
- **Dependency Injection**: Implemented using `GetIt`.
- **API Key Management**: Secured with `Envied`.
- **Networking**: Handled via the `http` package.
- **Import Management**: Using Dart's `part` technique to structure files efficiently.

## 📌 Usage
- Displays the current weather for a given location.
- Fetches data from OpenWeather API.
- Uses a modular and scalable architecture for maintainability.

## 📜 License
This project is open-source and available under the MIT License.
