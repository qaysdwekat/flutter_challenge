import '../core/storage/abstract_storage.dart';
import '../core/storage/storage_key.dart';
import '../core/utils/int_extention.dart';
import '../service/abstract_number_service.dart';
import 'abstract_number_repository.dart';

class NumberRepository extends AbstractNumberRepository {
  final AbstractNumberService service;
  final AbstractStorage storage;

  NumberRepository(this.service, this.storage);

  @override
  Future<int> fetchRandomNumber() async {
    try {
      // Get number from Service
      final result = await service.fetchRandomNumber();
      // Check if number is prime & save `newPrimeDate` to loacl storage
      if (result.isPrime) {
        await storage.set(StorageKey.newPrimeDate, DateTime.now().toIso8601String());
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DateTime?> getLastPrimeTime() async {
    try {
      // Read `lastPrimeDate` from local storage and try convert it to DateTime.
      final result = await storage.read(StorageKey.lastPrimeDate) as String;
      return DateTime.tryParse(result);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateLastPrimeDate() async {
    try {
      // Get `newPrimeDate` and update it `lastPrimeDate` with it. after display
      // the prime screen 2 keys used to avoid overwrite the time before open the screen
      final newDate = await storage.read(StorageKey.newPrimeDate) as String;
      return await storage.set(StorageKey.lastPrimeDate, newDate);
    } catch (e) {
      return false;
    }
  }
}
