import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodayCacheStorage {
  static const _responseKey = 'today_response';
  static const _savedDateKey = 'today_saved_date';

  /// 오늘의 운세 응답 저장
  static Future<void> saveResponse(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_responseKey, json.encode(response));
    await prefs.setString(_savedDateKey,
        DateTime.now().toIso8601String().substring(0, 10)); // yyyy-MM-dd
  }

  /// 오늘의 운세 응답 로드
  static Future<Map<String, dynamic>?> loadResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final savedDate = prefs.getString(_savedDateKey);

    // 저장된 날짜가 오늘이 아니면 null 반환
    if (savedDate != today) {
      await clearResponse();
      return null;
    }

    final responseString = prefs.getString(_responseKey);
    if (responseString == null) return null;

    return json.decode(responseString) as Map<String, dynamic>;
  }

  /// 캐시 초기화
  static Future<void> clearResponse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_responseKey);
    await prefs.remove(_savedDateKey);
  }
}