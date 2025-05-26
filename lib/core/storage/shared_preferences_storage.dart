import 'package:shared_preferences/shared_preferences.dart';

import 'abstract_storage.dart';
import 'storage_key.dart';

class SharedPreferencesStorage extends AbstractStorage {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<dynamic> read(StorageKey key) async {
    return _prefs.get(key.name);
  }

  @override
  Future<bool> set(StorageKey key, value) async {
    if (value is String) {
      return await _prefs.setString(key.name, value);
    } else {
      throw 'Type: ${value.runtimeType} not supported';
    }
  }
}
