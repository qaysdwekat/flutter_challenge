import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/date_time_extention.dart';
import 'package:flutter_challenge/core/utils/int_extention.dart';
import 'package:intl/intl.dart';

import '../repository/abstract_number_repository.dart';

class NumberViewModel extends ChangeNotifier {
  final AbstractNumberRepository repository;

  NumberViewModel(this.repository);

  late void Function(int prime, DateTime?) onPrimeFound;

  Timer? _timer;

  String get time {
    final now = DateTime.now();
    // Time format: h:m (e.g 23:00)
    return DateFormat.Hm().format(now);
  }

  String get date {
    final now = DateTime.now();
    // Day name short (e.g. So),
    // Day number (e.g. 2),
    // Month short (e.g. Feb)
    return DateFormat('E d. MMM.', 'de_DE').format(now);
  }

  int get weeknumber {
    final now = DateTime.now();
    return now.weekOfYear;
  }

  Future<void> _fetchNumber() async {
    try {
      // Fetch Random number from Repo
      final number = await repository.fetchRandomNumber();
      // Check if number is Prime get last Prime time from local storage & execute onPrimeFound callback
      if (number.isPrime) {
        final date = await repository.getLastPrimeTime();
        onPrimeFound(number, date);
        debugPrint('Prime number: $number, lastDate: ${date?.toIso8601String()}');
        // Update Last Prime time to the new time.
        await repository.updateLastPrimeDate();
      } else {
        debugPrint('Number: $number');
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching number: $e");
      // expose error to UI via state
    }
  }

  //Fetch number & Start the timer each 10 secs
  Future<void> startFetching() async {
    await _fetchNumber();
    _timer = Timer.periodic(Duration(seconds: 10), (_) async {
      _fetchNumber();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Stop timer
  void stopTimer() {
    _timer?.cancel();
  }
}
