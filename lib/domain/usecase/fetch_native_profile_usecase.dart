import 'package:flutter_native/data/repository/pnative_profile_repository.dart';

class FetchNativeProfileDataUseCase {
  final NativeProfileDataRepository _nativeProfileRepository;

  FetchNativeProfileDataUseCase(this._nativeProfileRepository);

  Future<Map<String, dynamic>?> execute() async {
    return await _nativeProfileRepository.getProfileDataFromNative();
  }
}
