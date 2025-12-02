import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ProfileCacheService {
  static const String _profileKey = 'cached_profile';

  // To make sure GetStorage is initialized:
  GetStorage get _storage => GetStorage();

  // Save profile data to local cache
  Future<void> saveProfile(Map<String, dynamic> profileData) async {
    await _storage.write(_profileKey, profileData);
  }

  // Git cached profile data
  Map<String, dynamic>? getCachedProfile() {
    return _storage.read<Map<String, dynamic>>(_profileKey);
  }

  // Check if cached profile exists
  bool hasCachedProfile() {
    return _storage.hasData(_profileKey);
  }

  // Clear cached profile data
  Future<void> clearProfile() async {
    await _storage.remove(_profileKey);
  }

  // Clear all cache (for sign out)
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
