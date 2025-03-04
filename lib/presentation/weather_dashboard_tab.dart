part of home_lib;

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<_DashboardScreen> {
  final String city = "Cairo";
  final _WeatherDashboardViewModel viewModel = _WeatherDashboardViewModel();

  @override
  void initState() {
    viewModel.fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<WeatherModel?>(
        valueListenable: viewModel.weatherNotifier,
        builder: (context, weather, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(city,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
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
    viewModel.weatherNotifier.dispose();
    super.dispose();
  }
}
