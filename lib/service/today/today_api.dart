import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';

class TodayApi {
  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>> fetchTodayData(
      Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(
        Config.todayApiUrl,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: payload,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map) {
          return Map<String, dynamic>.from(data);
        } else {
          throw Exception("서버 응답이 Map 형식이 아님: ${data.runtimeType} → $data");
        }
      } else {
        throw Exception(
            "요청 실패 - 상태코드: ${response.statusCode}, 응답: ${response.data}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
