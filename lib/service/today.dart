import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getTodayRequestData() async {
  final prefs = await SharedPreferences.getInstance();

  final name = prefs.getString('name');
  final gender = prefs.getString('gender');
  final birthDate = prefs.getString('birthDate');
  final solarType = prefs.getString('solar'); // "solar", "lunar", "lunarLeaf"
  final birthTime = prefs.getString('birthTime'); // nullable

  if (name == null ||
      gender == null ||
      birthDate == null ||
      solarType == null) {
    throw Exception("필수 정보 누락");
  }

  return {
    "name": name,
    "gender": gender,
    "birthDate": birthDate,
    "solar": solarType,
    "birthTime": birthTime, // 그대로 nullable
  };
}
