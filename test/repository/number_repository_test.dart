// Define a mock class for any dependencies
import 'dart:math';

import 'package:flutter_challenge/core/storage/abstract_storage.dart';
import 'package:flutter_challenge/core/storage/storage_key.dart';
import 'package:flutter_challenge/repository/abstract_number_repository.dart';
import 'package:flutter_challenge/repository/number_repository.dart';
import 'package:flutter_challenge/service/abstract_number_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../service/number_service_test.mocks.dart';
import 'number_repository_test.mocks.dart';

class TestNumberRepository extends Mock implements AbstractNumberRepository {}

class NumberService extends Mock implements AbstractNumberService {}

class Storage extends Mock implements AbstractStorage {}

@GenerateMocks([TestNumberRepository, NumberService, Storage])
void main() {
  testNumberRepositoryAbstraction();
  testFetchRandomNumberImplementation();
  testGetLastPrimeTimeImplementation();
  testupdateLastPrimeDateImplementation();
}

void testNumberRepositoryAbstraction() {
  AbstractNumberRepository repository = MockTestNumberRepository();

  final List<Map<String, dynamic>> fetchRandomTestCases = [
    {
      'description': 'Should Fetch valid random number',
      'expectedResult': Random().nextInt(100),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should throw an exception when no response',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Something went wrong'),
    },
  ];

  group('Fetch random numberTest', () {
    for (var testCase in fetchRandomTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the fetchRandomNumber method in the MockTestNumberRepository
        if (expectedError) {
          when(repository.fetchRandomNumber()).thenThrow(error);
        } else {
          when(repository.fetchRandomNumber()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final int result = await repository.fetchRandomNumber();

          verify(repository.fetchRandomNumber());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.fetchRandomNumber());
          expect(e, error);
        }
      });
    }
  });

  final List<Map<String, dynamic>> getLastPrimeTimeTestCases = [
    {
      'description': 'Should return a valid Date if it exist',
      'expectedResult': DateTime.now(),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return null if no Date exist',
      'expectedResult': DateTime.now(),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should throw an exception when the no valid date',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Date not valid'),
    },
  ];

  group('Get last prime time Test', () {
    for (var testCase in getLastPrimeTimeTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the fetchRandomNumber method in the MockTestNumberRepository
        if (expectedError) {
          when(repository.getLastPrimeTime()).thenThrow(error);
        } else {
          when(repository.getLastPrimeTime()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final DateTime? result = await repository.getLastPrimeTime();

          verify(repository.getLastPrimeTime());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.getLastPrimeTime());
          expect(e, error);
        }
      });
    }
  });

  final List<Map<String, dynamic>> updateLastPrimeDateTestCases = [
    {'description': 'Should Fetch valid random number', 'expectedResult': true, 'expectedError': false, 'error': null},
    {
      'description': 'Should throw an exception when no response',
      'expectedResult': false,
      'expectedError': true,
      'error': Exception('Something went wrong'),
    },
  ];

  group('Update Last Prime Date Test', () {
    for (var testCase in updateLastPrimeDateTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the updateLastPrimeDate method in the MockTestNumberRepository
        if (expectedError) {
          when(repository.updateLastPrimeDate()).thenThrow(error);
        } else {
          when(repository.updateLastPrimeDate()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final bool result = await repository.updateLastPrimeDate();

          verify(repository.updateLastPrimeDate());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.updateLastPrimeDate());
          expect(e, error);
        }
      });
    }
  });
}

void testFetchRandomNumberImplementation() {
  final AbstractNumberService service = MockTestNumberService();
  final AbstractStorage storage = MockStorage();

  final AbstractNumberRepository repository = NumberRepository(service, storage);

  final List<Map<String, dynamic>> numberServiceTestCases = [
    {
      'description': 'Should return a number when the response is valid List of int',
      'serviceResult': 12,
      'expectedResult': 12,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return a Prime number when the response is valid List of int',
      'serviceResult': 7,
      'expectedResult': 7,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should throw an error when servise has exception',
      'serviceResult': Exception('Something went wrong'),
      'expectedResult': 12,
      'expectedError': true,
      'error': Exception('Something went wrong'),
    },
  ];

  group('Number service implementation Test', () {
    for (var testCase in numberServiceTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final serviceResult = testCase['serviceResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the get method in the MockStorage
        when(storage.set(StorageKey.newPrimeDate, any)).thenAnswer((_) async => true);
        // Mock the get method in the MockTestNumberService
        if (expectedError) {
          when(service.fetchRandomNumber()).thenThrow(serviceResult);
        } else {
          when(service.fetchRandomNumber()).thenAnswer((_) async => serviceResult);
        }

        // Call the method and verify the expectations
        try {
          final int result = await repository.fetchRandomNumber();

          verify(repository.fetchRandomNumber());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.fetchRandomNumber());
          expect(e.runtimeType, equals(error.runtimeType));
          expect(e.toString(), error.toString());
        }
      });
    }
  });
}

void testGetLastPrimeTimeImplementation() {
  final AbstractNumberService service = MockTestNumberService();
  final AbstractStorage storage = MockStorage();

  final AbstractNumberRepository repository = NumberRepository(service, storage);

  final List<Map<String, dynamic>> getLastPrimeTimeTestCases = [
    {
      'description': 'Should return a valid Date if it exist',
      'storageResult': '2025-05-26T14:04:05.361113',
      'expectedResult': DateTime.parse('2025-05-26T14:04:05.361113'),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return null if no Date exist',
      'storageResult': '2025',
      'expectedResult': null,
      'expectedError': false,
      'error': null,
    },
  ];

  group('GetLastPrimeTime repository implementation Test', () {
    for (var testCase in getLastPrimeTimeTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final storageResult = testCase['storageResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the get method in the MockStorage
        when(storage.read(StorageKey.lastPrimeDate)).thenAnswer((_) async => storageResult);

        // Call the method and verify the expectations
        try {
          final DateTime? result = await repository.getLastPrimeTime();

          verify(repository.getLastPrimeTime());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.getLastPrimeTime());
          expect(e.runtimeType, equals(error.runtimeType));
          expect(e.toString(), error.toString());
        }
      });
    }
  });
}

void testupdateLastPrimeDateImplementation() {
  final AbstractNumberService service = MockTestNumberService();
  final AbstractStorage storage = MockStorage();

  final AbstractNumberRepository repository = NumberRepository(service, storage);

  final List<Map<String, dynamic>> updateLastPrimeDateTestCases = [
    {
      'description': 'Should return true if update success',
      'readStorageResult': '2025-05-26T14:04:05.361113',
      'setStorageResult': true,
      'expectedResult': true,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should return false if update fail',
      'readStorageResult': 12,
      'setStorageResult': true,
      'expectedResult': false,
      'expectedError': false,
      'error': null,
    },
  ];

  group('UpdateLastPrimeDate repository implementation Test', () {
    for (var testCase in updateLastPrimeDateTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final readStorageResult = testCase['readStorageResult'];
      final setStorageResult = testCase['setStorageResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the get method in the MockStorage
        when(storage.read(StorageKey.newPrimeDate)).thenAnswer((_) async => readStorageResult);

        when(storage.set(StorageKey.lastPrimeDate, any)).thenAnswer((_) async => setStorageResult);

        // Call the method and verify the expectations
        try {
          final bool result = await repository.updateLastPrimeDate();

          verify(repository.updateLastPrimeDate());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.updateLastPrimeDate());
          expect(e.runtimeType, equals(error.runtimeType));
          expect(e.toString(), error.toString());
        }
      });
    }
  });
}
