import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/date_time_extention.dart';
import 'package:flutter_challenge/main.dart' as app;
import 'package:flutter_challenge/view/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Wait for 2 prime numbers or timeout', (WidgetTester tester) async {
    //Run the App
    app.main();
    await tester.pumpAndSettle();
    //Check if HomeScreen presented
    expect(find.byType(HomeScreen), findsOneWidget);

    int primeCount = 0;
    final Completer<void> primeCompleter = Completer();

    final stopwatch = Stopwatch()..start();

    //Keep checking the UI for prime number appearance find 2 prime numbers or wait 5 mins
    while (stopwatch.elapsed.inMinutes < 5) {
      await tester.pumpAndSettle();
      //Delay until UI build
      await Future.delayed(Duration(seconds: 2));

      final primeScreenFinder = find.byKey(ValueKey('prime_screen'));
      // Check if Prime Screen Appeared
      if (tester.any(primeScreenFinder)) {
        debugPrint('Found prime #$primeCount');

        // Check if Prime Screen title Appeared
        expect(find.text('Congrats!'), findsOneWidget);
        //Delay until UI build
        await Future.delayed(Duration(seconds: 2));

        // Last Prime Date Widget Key
        final lastPrimeDateFinder = find.byKey(ValueKey('last_prime_number_date'));

        if (primeCount > 0) {
          // Check if Last Prime Date Widget Appeared
          expect(lastPrimeDateFinder, findsOneWidget);
        } else {
          // Check if Last Prime Date Widget Not Appeared (First time to get Prime number)
          expect(lastPrimeDateFinder, findsNothing);
        }
        primeCount++;
        // Tap close button and verify you're back
        await tester.tap(find.byKey(ValueKey('close_button')));
        await tester.pumpAndSettle();

        if (primeCount >= 2) {
          primeCompleter.complete();
          break;
        }
      } else {
        //Delay until UI build
        await Future.delayed(Duration(seconds: 2));

        final now = DateTime.now();
        final time = DateFormat.Hm().format(now);
        final date = DateFormat('E d. MMM.', 'de_DE').format(now);
        final weeknumber = now.weekOfYear;

        // Verify that our screen display the Time & Date & KW
        expect(find.text(time), findsOneWidget);
        // Partial match of text
        expect(find.textContaining(date.split(' ').first), findsOneWidget);
        expect(find.text('KW $weeknumber'), findsOneWidget);
      }
    }
    debugPrint('Test completed in: ${stopwatch.elapsed.inSeconds}s');
    stopwatch.stop();
  });
}
