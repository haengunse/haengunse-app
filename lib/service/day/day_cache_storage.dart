import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DayCacheStorage {
  static const _randomMessageKey = 'day_random_message';
  static const _cookieMessageKey = 'day_cookie_message';
  static const _itemDataKey = 'day_item_data';
  static const _savedDateKey = 'day_saved_date';

  /// 날짜 확인 및 캐시 초기화
  static Future<bool> _checkAndClearIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final savedDate = prefs.getString(_savedDateKey);

    if (savedDate != today) {
      await clearAll();
      await prefs.setString(_savedDateKey, today);
      return false; // 캐시가 초기화됨
    }
    return true; // 캐시가 유효함
  }

  /// 랜덤 메시지 저장
  static Future<void> saveRandomMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_randomMessageKey, message);
    await prefs.setString(_savedDateKey,
        DateTime.now().toIso8601String().substring(0, 10));
  }

  /// 랜덤 메시지 로드
  static Future<String?> loadRandomMessage() async {
    final isValid = await _checkAndClearIfNeeded();
    if (!isValid) return null;
    
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_randomMessageKey);
  }

  /// 쿠키 메시지 저장
  static Future<void> saveCookieMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cookieMessageKey, message);
    await prefs.setString(_savedDateKey,
        DateTime.now().toIso8601String().substring(0, 10));
  }

  /// 쿠키 메시지 로드
  static Future<String?> loadCookieMessage() async {
    final isValid = await _checkAndClearIfNeeded();
    if (!isValid) return null;
    
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cookieMessageKey);
  }

  /// 아이템 데이터 저장
  static Future<void> saveItemData(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_itemDataKey, json.encode(item));
    await prefs.setString(_savedDateKey,
        DateTime.now().toIso8601String().substring(0, 10));
  }

  /// 아이템 데이터 로드
  static Future<Map<String, dynamic>?> loadItemData() async {
    final isValid = await _checkAndClearIfNeeded();
    if (!isValid) return null;
    
    final prefs = await SharedPreferences.getInstance();
    final itemString = prefs.getString(_itemDataKey);
    if (itemString == null) return null;
    
    return json.decode(itemString) as Map<String, dynamic>;
  }

  /// 전체 캐시 초기화
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_randomMessageKey);
    await prefs.remove(_cookieMessageKey);
    await prefs.remove(_itemDataKey);
  }
}