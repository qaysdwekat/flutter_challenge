import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_challenge/service/abstract_number_service.dart';
import 'package:flutter_challenge/service/number_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_service_test.mocks.dart';

// Define a mock class for any dependencies
class TestNumberService extends Mock implements AbstractNumberService {}

class TestDio extends Mock implements Dio {}

@GenerateMocks([TestNumberService, TestDio])
void main() {
  testNumberServiceAbstraction();
  testNumberServiceImplementation();
}

void testNumberServiceImplementation() {
  final client = MockTestDio();
  final path = 'random';
  AbstractNumberService service = NumberService(client);

  final List<Map<String, dynamic>> numberServiceTestCases = [
    {
      'description': 'Should return a number when the response is valid List of int',
      'clientResult': Response(data: [12], requestOptions: RequestOptions(path: path)),
      'expectedResult': 12,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should throw an exception when no response',
      'clientResult': null,
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Something went wrong while fetching the number.'),
    },
    {
      'description': 'Should throw an exception when the response is not valid List of int',
      'clientResult': Response(data: ['12'], requestOptions: RequestOptions(path: path)),
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Something went wrong while fetching the number.'),
    },
    {
      'description': 'Should throw an exception when the response is not valid formate',
      'clientResult': Response(data: 12, requestOptions: RequestOptions(path: path)),
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Something went wrong while fetching the number.'),
    },
  ];

  group('Number service implementation Test', () {
    for (var testCase in numberServiceTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final clientResult = testCase['clientResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the get method in the MockTestDio
        when(client.get(path)).thenAnswer((_) async => clientResult);

        // Call the method and verify the expectations
        try {
          final int result = await service.fetchRandomNumber();

          verify(client.get(path));

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(client.get(path));
          expect(e.runtimeType, equals(error.runtimeType));
          expect(e.toString(), error.toString());
        }
      });
    }
  });
}

void testNumberServiceAbstraction() {
  AbstractNumberService service = MockTestNumberService();

  final List<Map<String, dynamic>> numberServiceTestCases = [
    {
      'description': 'Should return a number when the response is valid',
      'expectedResult': Random().nextInt(100),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Should throw an exception when the response is not valid',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Something went wrong'),
    },
  ];

  group('Number service abstraction Test', () {
    for (var testCase in numberServiceTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the fetchRandomNumber method in the MockTestNumberService
        if (expectedError) {
          when(service.fetchRandomNumber()).thenThrow(error);
        } else {
          when(service.fetchRandomNumber()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final int result = await service.fetchRandomNumber();

          verify(service.fetchRandomNumber());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(service.fetchRandomNumber());
          expect(e, error);
        }
      });
    }
  });
}
