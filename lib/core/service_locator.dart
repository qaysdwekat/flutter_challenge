import 'package:dio/dio.dart';
import 'package:flutter_challenge/core/storage/abstract_storage.dart';
import 'package:get_it/get_it.dart';

import '../repository/abstract_number_repository.dart';
import '../repository/number_repository.dart';
import '../service/abstract_number_service.dart';
import '../service/number_service.dart';
import '../viewmodel/number_view_model.dart';
import 'storage/shared_preferences_storage.dart';

final sl = GetIt.instance;

// Base Url of randomnumberapi to be used in Dio Clinet,
// This should be moved to config file of the app and should'nt hardcoded
const baseUrl = 'http://www.randomnumberapi.com/api/v1.0/';

Future<void> init() async {
  // Init Dio Network here & inject it to be able to write the unit test for NumberService.
  final url = Uri.parse(baseUrl);
  final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    // Host is required to avoid CORS issue with randomnumberapi.
    headers: {'host': url.host},
  );

  final client = Dio(options);

  final service = NumberService(client);

  sl.registerLazySingleton<AbstractNumberService>(() => service);

  // Setup SharedPreferences
  final storage = SharedPreferencesStorage();
  await storage.init();
  sl.registerLazySingleton<AbstractStorage>(() => storage);

  sl.registerLazySingleton<AbstractNumberRepository>(() => NumberRepository(sl.call(), sl.call()));

  sl.registerFactory(() => NumberViewModel(sl.call()));
}
