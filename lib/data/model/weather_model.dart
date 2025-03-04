class WeatherModel {
  final String temperature;
  final String condition;

  WeatherModel({required this.temperature, required this.condition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: "${json['main']['temp']}°C",
      condition: json['weather'][0]['description'],
    );
  }
}
