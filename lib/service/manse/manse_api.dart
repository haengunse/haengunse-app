import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/config.dart';

class ManseApiService {
  final Dio _dio = Dio();

  Future<bool> sendManseData(Map<String, dynamic> payload) async {
    try {
      final response = await _dio.post(
        Config.manseUrl,
        data: payload,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isFirstRun', false);
        await prefs.setString('name', data['name'] ?? "이름없음");
        await prefs.setString('gender', data['gender'] ?? "모름");
        await prefs.setString('manseInfo', data['manseInfo'] ?? "해석 정보 없음");

        return true;
      } else {
        throw Exception("서버 상태 코드 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending manse data: $e");
      rethrow;
    }
  }
}
