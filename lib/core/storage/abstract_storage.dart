
import 'storage_key.dart';

abstract class AbstractStorage {
  Future<bool> set(StorageKey key, dynamic value);
  Future<dynamic> read(StorageKey key);
}
