import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SajuCacheStorage {
  static const _sajuResponseKey = 'saju_response';
  static const _cachedManseKey = 'saju_cached_manse';

  /// 사주 응답 저장
  static Future<void> saveResponse(Map<String, dynamic> response, String manseInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sajuResponseKey, json.encode(response));
    await prefs.setString(_cachedManseKey, manseInfo);
  }

  /// 사주 응답 로드
  static Future<Map<String, dynamic>?> loadResponse() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 현재 저장된 manse 정보와 캐시된 manse 정보 비교
    final currentManse = prefs.getString('manseInfo') ?? '';
    final cachedManse = prefs.getString(_cachedManseKey) ?? '';
    
    // manse 정보가 다르면 캐시 무효화
    if (currentManse != cachedManse) {
      await clearResponse();
      return null;
    }
    
    final responseString = prefs.getString(_sajuResponseKey);
    if (responseString == null) return null;
    
    return json.decode(responseString) as Map<String, dynamic>;
  }

  /// 캐시 초기화 (정보 삭제 시 호출)
  static Future<void> clearResponse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sajuResponseKey);
    await prefs.remove(_cachedManseKey);
  }
}