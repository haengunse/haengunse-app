import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';

class TodayApi {
  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>> fetchTodayData(
      Map<String, dynamic> payload) async {
    try {
      final response = await _dio.get(
        Config.todayApiUrl,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: payload,
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        throw Exception("Invalid response format or status");
      }
    } catch (e) {
      rethrow;
    }
  }
}
