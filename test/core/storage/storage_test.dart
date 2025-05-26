import 'package:flutter_challenge/core/storage/abstract_storage.dart';
import 'package:flutter_challenge/core/storage/storage_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'storage_test.mocks.dart';

class TestStorage extends Mock implements AbstractStorage {}

@GenerateMocks([TestStorage])
void main() {
  AbstractStorage storage = MockTestStorage();

  final List<Map<String, dynamic>> readStorageTestCases = [
    {'description': 'Should read int value form stroage', 'expectedResult': 100, 'expectedError': false, 'error': null},
    {
      'description': 'Should read String value form stroage',
      'expectedResult': 'We are testing storage abstraction',
      'expectedError': false,
      'error': null,
    },
  ];

  group('Read From Storge Test', () {
    for (var testCase in readStorageTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the fetchRandomNumber method in the MockTestNumberRepository
        if (expectedError) {
          when(storage.read(StorageKey.newPrimeDate)).thenThrow(error);
        } else {
          when(storage.read(StorageKey.newPrimeDate)).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await storage.read(StorageKey.newPrimeDate);

          verify(storage.read(StorageKey.newPrimeDate));

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(storage.read(StorageKey.newPrimeDate));
          expect(e, error);
        }
      });
    }
  });

  final List<Map<String, dynamic>> setStorageTestCases = [
    {
      'description': 'Should write int value to stroage',
      'expectedResult': true,
      'writeValue': 100,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should write String value to stroage',
      'writeValue': 'We are testing storage abstraction',
      'expectedResult': false,
      'expectedError': false,
      'error': null,
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
        // Mock the fetchRandomNumber method in the MockTestNumberRepository
        if (expectedError) {
          when(storage.set(StorageKey.newPrimeDate, writeValue)).thenThrow(error);
        } else {
          when(storage.set(StorageKey.newPrimeDate, writeValue)).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await storage.set(StorageKey.newPrimeDate, writeValue);

          verify(storage.set(StorageKey.newPrimeDate, writeValue));

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(storage.set(StorageKey.newPrimeDate, writeValue));
          expect(e, error);
        }
      });
    }
  });
}
