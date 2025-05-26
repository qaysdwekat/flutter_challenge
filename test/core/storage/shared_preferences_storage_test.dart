import 'package:flutter_challenge/core/storage/shared_preferences_storage.dart';
import 'package:flutter_challenge/core/storage/storage_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferencesStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({StorageKey.lastPrimeDate.name: 'Last Prime Date'}); // Clear preferences
    storage = SharedPreferencesStorage();
    await storage.init();
  });

  final List<Map<String, dynamic>> setStorageTestCases = [
    {
      'description': 'Should write String value to stroage',
      'writeValue': 'We are testing storage abstraction',
      'expectedResult': true,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return error if Type not supported',
      'expectedResult': true,
      'writeValue': 100,
      'expectedError': true,
      'error': 'Type: int not supported',
    },
  ];

  group('Write To Storge Test', () {
    for (var testCase in setStorageTestCases) {
      final description = testCase['description'];
      final writeValue = testCase['writeValue'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Call the method and verify the expectations
        try {
          final result = await storage.set(StorageKey.newPrimeDate, writeValue);

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          expect(e, error);
        }
      });
    }
  });

  final List<Map<String, dynamic>> readStorageTestCases = [
    {
      'description': 'Should return String value if key value found  stroage',
      'readKey': StorageKey.lastPrimeDate,
      'expectedResult': 'Last Prime Date',
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return null if no value found',
      'readKey': StorageKey.newPrimeDate,
      'expectedResult': null,
      'expectedError': false,
      'error': null,
    },
  ];

  group('Read From Storge Test', () {
    for (var testCase in readStorageTestCases) {
      final description = testCase['description'];
      final readKey = testCase['readKey'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Call the method and verify the expectations
        try {
          final result = await storage.read(readKey);

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          expect(e, error);
        }
      });
    }
  });
}
