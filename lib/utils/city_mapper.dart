import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityMapper {
  static final Map<int, String> _cityIdToKoreanName = {};

  static Future<void> loadCityMap() async {
    final jsonString = await rootBundle.loadString('assets/city.list.kr.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var item in jsonList) {
      final int? id = item['id'];
      final String? name = item['name'];

      if (id != null && name != null) {
        _cityIdToKoreanName[id] = name;
      }
    }
  }

  static String getCityName(
      {required int cityId, required String fallbackName}) {
    return _cityIdToKoreanName[cityId] ?? fallbackName;
  }
}
