import 'package:flutter_challenge/core/utils/date_time_extention.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<Map<String, dynamic>> readStorageTestCases = [
    {
      'description': 'returns correct week number for start of year',
      'date': DateTime(2025, 1, 1),
      'expectedResult': 1,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'returns correct week number for mid-year date',
      'date': DateTime(2025, 6, 15),
      'expectedResult': 24,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'returns correct week number for end of year',
      'date': DateTime(2025, 12, 28),
      'expectedResult': 52,
      'expectedError': false,
      'error': null,
    },
  ];

  group('DateTimeExtension.weekOfYear', () {
    for (var testCase in readStorageTestCases) {
      final description = testCase['description'];
      final DateTime date = testCase['date'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Call the method and verify the expectations
        try {
          final result = date.weekOfYear;

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
