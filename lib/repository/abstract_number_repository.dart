abstract class AbstractNumberRepository {
  Future<int> fetchRandomNumber();
  Future<DateTime?> getLastPrimeTime();
  Future<bool> updateLastPrimeDate();
}
