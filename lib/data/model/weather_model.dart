class WeatherModel {
  final String? temperature;
  final String? condition;

  WeatherModel({required this.temperature, required this.condition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['main'] == null && json['weather'] == null) {
      return WeatherModel(temperature: "Not Fetched", condition: "Not Fetched");
    }
    return WeatherModel(
      temperature: "${json['main']['temp']}°C",
      condition: json['weather'][0]['description'],
    );
  }
}
