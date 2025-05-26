import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/date_time_extention.dart';
import 'package:flutter_challenge/repository/abstract_number_repository.dart';
import 'package:flutter_challenge/viewmodel/number_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_view_model_test.mocks.dart';

class NumberRepository extends Mock implements AbstractNumberRepository {}

@GenerateMocks([NumberRepository])
void main() {
  late AbstractNumberRepository repository;
  late NumberViewModel viewModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initializeDateFormatting('de_DE', null); // Initialize German locale

    repository = MockNumberRepository();
    viewModel = NumberViewModel(repository);
  });

  test('Should format time correctly', () {
    final now = DateTime.now();
    final current = DateFormat.Hm().format(now);
    final expected = viewModel.time;
    expect(expected, isNotEmpty);
    expect(expected, current);
  });

  test('Should format date correctly', () {
    final now = DateTime.now();
    final current = DateFormat('E d. MMM.', 'de_DE').format(now);
    final expected = viewModel.date;
    expect(expected, isNotEmpty);
    expect(expected, current);
  });

  test('Should calculate week number correctly', () {
    final now = DateTime.now();
    final current = now.weekOfYear;
    final week = viewModel.weeknumber;
    expect(week, greaterThanOrEqualTo(1));
    expect(week, lessThanOrEqualTo(53));
    expect(week, current);
  });

  test('Should call fetchNumber and notifyListeners if not prime', () async {
    when(repository.fetchRandomNumber()).thenAnswer((_) async => 4); // Not prime

    var notified = false;
    viewModel.addListener(() {
      notified = true;
    });

    await viewModel.startFetching();
    viewModel.stopTimer();

    expect(notified, isTrue);
    verify(repository.fetchRandomNumber()).called(1);
    verifyNever(repository.getLastPrimeTime());
    verifyNever(repository.updateLastPrimeDate());
  });

  test('Should call fetchNumber, onPrimeFound, and update cache if prime', () async {
    final lastPrimeTime = DateTime.now().subtract(Duration(seconds: 150));
    when(repository.fetchRandomNumber()).thenAnswer((_) async => 7); // Prime
    when(repository.getLastPrimeTime()).thenAnswer((_) async => lastPrimeTime);
    when(repository.updateLastPrimeDate()).thenAnswer((_) async => true);

    int? capturedNumber;
    DateTime? capturedDate;
    viewModel.onPrimeFound = (int prime, DateTime? date) {
      capturedNumber = prime;
      capturedDate = date;
    };

    var notified = false;
    viewModel.addListener(() {
      notified = true;
    });

    await viewModel.startFetching();
    viewModel.stopTimer();

    expect(capturedNumber, equals(7));
    expect(notified, isTrue);
    expect(capturedDate, lastPrimeTime);
    verify(repository.fetchRandomNumber()).called(1);
    verify(repository.getLastPrimeTime()).called(1);
    verify(repository.updateLastPrimeDate()).called(1);
  });
}
//  flutter test --coverage
//  genhtml coverage/lcov.info -o coverage/html
//  open coverage/html/index.html