import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/config.dart';

class ManseApiService {
  final Dio _dio = Dio();

  Future<bool> sendManseData({
    required String name,
    required String gender,
    required String birthDate,
    required bool isSolar,
    required String birthTime,
  }) async {
    final requestBody = {
      "birthDate": birthDate,
      "solar": isSolar,
      "birthTime": birthTime.isEmpty ? "모름" : birthTime,
      "gender": gender,
      "name": name,
    };

    try {
      final response = await _dio.post(
        Config.manseUrl,
        data: requestBody,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isFirstRun', false);
        await prefs.setString('name', data['name'] ?? "이름없음");
        await prefs.setString('gender', data['gender'] ?? "모름");
        await prefs.setString('birthDate', birthDate);
        await prefs.setString('solar', isSolar.toString());
        await prefs.setString('birthTime', birthTime);
        await prefs.setString('manseInfo', data['manseInfo'] ?? "해석 정보 없음");

        return true;
      }
    } catch (e) {
      print('❌ Error sending manse data: $e');
    }

    return false;
  }
}
