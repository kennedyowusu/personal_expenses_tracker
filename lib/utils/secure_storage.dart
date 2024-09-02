import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LadderSecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _accessToken = 'access_token';

  Future<String> getAccessToken() async {
    return await _storage.read(key: _accessToken) ?? '';
  }

  Future<void> storeAccessToken(String token) async {
    await _storage.write(key: _accessToken, value: token);
  }

  Future<void> deleteAccessToken() async {
    return await _storage.delete(key: _accessToken);
  }
}
