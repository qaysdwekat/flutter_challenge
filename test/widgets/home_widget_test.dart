import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/service_locator.dart' as serviceLocator;
import 'package:flutter_challenge/core/utils/date_time_extention.dart';
import 'package:flutter_challenge/view/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initializeDateFormatting('de_DE', null); // Initialize German locale

    SharedPreferences.setMockInitialValues({}); // Clear preferences

    await serviceLocator.init();
  });
  testWidgets('Date Time Display Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Add a small delay to ensure the app initializes correctly
    await tester.pumpAndSettle();

    final now = DateTime.now();
    final time = DateFormat.Hm().format(now);
    final date = DateFormat('E d. MMM.', 'de_DE').format(now);
    final weeknumber = now.weekOfYear;

    // Verify that our screen display the time.
    expect(find.text(time), findsOneWidget);
    expect(find.textContaining(date.split(' ').first), findsOneWidget); // partial match
    expect(find.text('KW $weeknumber'), findsOneWidget);

    // Clean up the timer after test completes
    addTearDown(() {
      // Dispose your view model or reset any global timers
    });
  });
}
