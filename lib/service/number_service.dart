import 'package:dio/dio.dart';

import 'abstract_number_service.dart';

class NumberService implements AbstractNumberService {
  final Dio _dioClient;

  final String numberPath = 'random';

  NumberService(this._dioClient);

  @override
  Future<int> fetchRandomNumber() async {
    try {
      // Get random number from API and try to parse it.
      final response = await _dioClient.get(numberPath);
      final data = response.data;
      // Current response of API is List of Int.
      // Check if data is list then get first item.
      if (data is List && data.isNotEmpty) {
        return data.first as int;
      } else {
        throw Exception('Unexpected data format: $data');
      }
    } catch (e) {
      throw Exception('Something went wrong while fetching the number.');
    }
  }
}
