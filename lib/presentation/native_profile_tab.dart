part of home_lib;

class _NativeProfileScreen extends StatefulWidget {
  const _NativeProfileScreen();

  @override
  State<_NativeProfileScreen> createState() => _NativeProfileScreenState();
}

class _NativeProfileScreenState extends State<_NativeProfileScreen> {
  final _NativeProfileViewModel _viewModel = _NativeProfileViewModel();

  @override
  void initState() {
    _viewModel.fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: _viewModel.profileDataNotifier,
      builder: (context, profileData, child) {
        if (profileData == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    FileImage(File(profileData['profile_picture'])),
              ),
              const SizedBox(height: 16),
              Text("Name: ${profileData['name']}",
                  style: const TextStyle(fontSize: 24)),
              Text("Email: ${profileData['email']}",
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }
}
