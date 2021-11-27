import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() => _instance;

  SecureStorage._internal();

  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String token = '';

  Future<String> getData(String dataKey) async {
    return await SecureStorage().secureStorage.read(key: dataKey) ?? '';
  }

  Future<void> saveData(String dataValue, String dataKey) async {
    await SecureStorage().secureStorage.write(key: dataKey, value: dataValue);
  }

  Future<void> cleanUserData() async {
    await SecureStorage().secureStorage.delete(key: 'access_token');
    await SecureStorage().secureStorage.delete(key: 'role');
  }
}
