part of home_lib;

class _NativeProfileScreen extends StatelessWidget {
  final ValueNotifier<Map<String, dynamic>?> profileDataNotifier;

  const _NativeProfileScreen({super.key, required this.profileDataNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: profileDataNotifier,
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
