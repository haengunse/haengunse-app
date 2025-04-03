import 'package:dio/dio.dart';

class DayService {
  static final Dio _dio = Dio();

  static Future<String> fetchAnswer(String url) async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data['answer'] ?? '알 수 없음';
      } else {
        throw Exception('응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('요청 실패: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchItem(String url) async {
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('요청 실패: $e');
    }
  }
}
