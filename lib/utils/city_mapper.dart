import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityMapper {
  static Map<int, String>? _cityIdMap;

  static Future<void> loadCityMap() async {
    if (_cityIdMap != null) return; // 이미 불러왔으면 생략
    final jsonStr = await rootBundle.loadString('assets/city.list.kr.json');
    final decoded = json.decode(jsonStr) as Map<String, dynamic>;
    _cityIdMap = decoded.map((key, value) => MapEntry(int.parse(key), value));
  }

  static String getKoreanCityById(int id) {
    return _cityIdMap?[id] ?? '알 수 없음';
  }
}
