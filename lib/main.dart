import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // For initializeDateFormatting

import './core/service_locator.dart' as serviceLocator;
import 'view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize German locale
  await initializeDateFormatting('de_DE', null);
  // initialize dependency injection
  await serviceLocator.init();

  runApp(const MaterialApp(home: HomeScreen()));
}
