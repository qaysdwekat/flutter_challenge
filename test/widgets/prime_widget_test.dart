import 'package:flutter/material.dart';
import 'package:flutter_challenge/view/prime_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Date Time Display Test', (WidgetTester tester) async {
    final date = DateTime.now();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: PrimeScreen(prime: 7, lastPrimeTime: date),
      ),
    );

    // Add a small delay to ensure the app initializes correctly
    await tester.pumpAndSettle();

    // Verify that our screen display the Title & prime message.
    expect(find.text('Congrats!'), findsOneWidget);
    expect(find.textContaining('You obtained a prime number, it was:'), findsOneWidget); // partial match
  });
}
