import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  // Keys for storing data
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  // Secure storage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save Access Token (Secure)
  Future<void> saveAccessTokenSecure(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
    print('Access token securely saved: $token');
  }

  // Save Refresh Token (Secure)
  Future<void> saveRefreshTokenSecure(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
    print('Refresh token securely saved: $token');
  }

  // Save Data in SharedPreferences (Non-Secure)
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print('Data saved in SharedPreferences: $key = $value');
  }

  // Read Access Token (Secure)
  Future<String?> readAccessTokenSecure() async {
    final token = await _secureStorage.read(key: _accessTokenKey);
    print('Access token securely read: $token');
    return token;
  }

  Future<String?> readAllData(String key) async {
    if (kIsWeb) {
      return await readData(key);
    } else {
      return await readAccessTokenSecure();
    }
  }

  // Read Refresh Token (Secure)
  Future<String?> readRefreshTokenSecure() async {
    final token = await _secureStorage.read(key: _refreshTokenKey);
    print('Refresh token securely read: $token');
    return token;
  }

  // Read Data from SharedPreferences (Non-Secure)
  Future<String?> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    print('Data read from SharedPreferences: $key = $value');
    return value;
  }

  // Delete Access Token (Secure)
  Future<void> deleteAccessTokenSecure() async {
    await _secureStorage.delete(key: _accessTokenKey);
    print('Access token securely deleted.');
  }

  // Delete Refresh Token (Secure)
  Future<void> deleteRefreshTokenSecure() async {
    await _secureStorage.delete(key: _refreshTokenKey);
    print('Refresh token securely deleted.');
  }

  // Clear All Data in SharedPreferences (Non-Secure)
  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('All SharedPreferences data cleared.');
  }

  // Clear All Data in Secure Storage
  Future<void> clearAllSecureData() async {
    await _secureStorage.deleteAll();
    print('All secure data cleared.');
  }
}
