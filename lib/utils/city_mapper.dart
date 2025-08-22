import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityMapper {
  static final Map<int, String> _cityIdToKoreanName = {};

  static Future<void> loadCityMap() async {
    final jsonString = await rootBundle.loadString('assets/city.list.kr.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    for (var entry in jsonMap.entries) {
      final String cityIdString = entry.key;
      final String koreanName = entry.value;

      final int? cityId = int.tryParse(cityIdString);
      if (cityId != null) {
        _cityIdToKoreanName[cityId] = koreanName;
      }
    }
  }

  static String getCityName(
      {required int cityId, required String fallbackName}) {
    return _cityIdToKoreanName[cityId] ?? fallbackName;
  }
}
