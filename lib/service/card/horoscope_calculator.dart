import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HoroscopeCalculator {
  static Future<String?> getStarSign() async {
    final prefs = await SharedPreferences.getInstance();
    final birthDateStr = prefs.getString('birthDate');
    if (birthDateStr == null) return null;

    final birthDate = _parseDate(birthDateStr);
    if (birthDate == null) return null;

    return _getStarSignFromDate(birthDate);
  }

  static Future<String?> getZodiacAnimal() async {
    final prefs = await SharedPreferences.getInstance();
    final birthDateStr = prefs.getString('birthDate');
    if (birthDateStr == null) return null;

    final birthDate = _parseDate(birthDateStr);
    if (birthDate == null) return null;

    return _getZodiacAnimalFromYear(birthDate.year);
  }

  static DateTime? _parseDate(String dateStr) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(dateStr);
    } catch (_) {
      return null;
    }
  }

  static String _getStarSignFromDate(DateTime date) {
    final month = date.month;
    final day = date.day;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return '물병자리';
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return '물고기자리';
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return '양자리';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return '황소자리';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return '쌍둥이자리';
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return '게자리';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return '사자자리';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return '처녀자리';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return '천칭자리';
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return '전갈자리';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return '사수자리';
    return '염소자리';
  }

  static String _getZodiacAnimalFromYear(int year) {
    const animals = [
      '원숭이띠',
      '닭띠',
      '개띠',
      '돼지띠',
      '쥐띠',
      '소띠',
      '호랑이띠',
      '토끼띠',
      '용띠',
      '뱀띠',
      '말띠',
      '양띠'
    ];
    return animals[year % 12];
  }
}
