/// 공통 인터페이스
abstract class BaseFortune {
  String get titleName; // 띄울 이름 (starName or ageName)
  String get mainMessage;
  String get bestMatch;
  String get worstMatch;
}

/// 띠 운세 (zodiac)
class ZodiacFortune implements BaseFortune {
  final String ageName;
  final String mainMessage;
  final String bestMatch;
  final String worstMatch;

  ZodiacFortune({
    required this.ageName,
    required this.mainMessage,
    required this.bestMatch,
    required this.worstMatch,
  });

  factory ZodiacFortune.fromJson(Map<String, dynamic> json) {
    return ZodiacFortune(
      ageName: json['ageName'] ?? '',
      mainMessage: json['content']?['mainMessage'] ?? '',
      bestMatch: json['content']?['bestMatch'] ?? '',
      worstMatch: json['content']?['worstMatch'] ?? '',
    );
  }

  @override
  String get titleName => ageName;
}

/// 별자리 운세 (star)
class StarFortune implements BaseFortune {
  final String starName;
  final String dateRange;
  final String mainMessage;
  final String bestMatch;
  final String worstMatch;

  StarFortune({
    required this.starName,
    required this.dateRange,
    required this.mainMessage,
    required this.bestMatch,
    required this.worstMatch,
  });

  factory StarFortune.fromJson(Map<String, dynamic> json) {
    return StarFortune(
      starName: json['starName'] ?? '',
      dateRange: json['dateRange'] ?? '',
      mainMessage: json['content']?['mainMessage'] ?? '',
      bestMatch: json['content']?['bestMatch'] ?? '',
      worstMatch: json['content']?['worstMatch'] ?? '',
    );
  }

  @override
  String get titleName => starName;
}

const Map<String, String> koreanToHoroscopeEnglish = {
  '양자리': 'aries',
  '황소자리': 'taurus',
  '쌍둥이자리': 'gemini',
  '게자리': 'cancer',
  '사자자리': 'leo',
  '처녀자리': 'virgo',
  '천칭자리': 'libra',
  '전갈자리': 'scorpio',
  '사수자리': 'sagittarius',
  '염소자리': 'capricorn',
  '물병자리': 'aquarius',
  '물고기자리': 'pisces',
};

const Map<String, String> koreanToZodiacEnglish = {
  '쥐띠': 'rat',
  '소띠': 'ox',
  '호랑이띠': 'tiger',
  '토끼띠': 'rabbit',
  '용띠': 'dragon',
  '뱀띠': 'snake',
  '말띠': 'horse',
  '양띠': 'goat',
  '원숭이띠': 'monkey',
  '닭띠': 'rooster',
  '개띠': 'dog',
  '돼지띠': 'pig',
};

/// 별자리 / 띠 운세 모드
enum HoroscopeMode {
  star,
  zodiac,
}
