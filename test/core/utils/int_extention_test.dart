import 'package:flutter_challenge/core/utils/int_extention.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<Map<String, dynamic>> readStorageTestCases = [
    {'description': 'Check if 1 is prime number', 'number': 1, 'expectedResult': false},
    {'description': 'Check if 2 is prime number', 'number': 2, 'expectedResult': true},
    {'description': 'Check if 19 is prime number', 'number': 2, 'expectedResult': true},
    {'description': 'Check if 47 is prime number', 'number': 2, 'expectedResult': true},
    {'description': 'Check if 83 is prime number', 'number': 2, 'expectedResult': true},
    {'description': 'Check if 97 is prime number', 'number': 2, 'expectedResult': true},
    {'description': 'Check if 15 is prime number', 'number': 15, 'expectedResult': false},
    {'description': 'Check if 24 is prime number', 'number': 34, 'expectedResult': false},
    {'description': 'Check if 90 is prime number', 'number': 90, 'expectedResult': false},
    {'description': 'Check if 99 is prime number', 'number': 99, 'expectedResult': false},
    {'description': 'Check if 33 is prime number', 'number': 33, 'expectedResult': false},
  ];

  group('IntExtension.isPrime', () {
    for (var testCase in readStorageTestCases) {
      final description = testCase['description'];
      final int number = testCase['number'];
      final expectedResult = testCase['expectedResult'];

      test(description, () async {
        final result = number.isPrime;

        expect(result, expectedResult);
      });
    }
  });
}
