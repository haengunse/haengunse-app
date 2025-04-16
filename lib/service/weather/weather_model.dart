class Weather {
  final int cityId;
  final String cityName;
  final String condition;
  final String iconCode;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double? rainfall;

  Weather({
    required this.cityId,
    required this.cityName,
    required this.condition,
    required String iconCode,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    this.rainfall,
  }) : iconCode = _forceDayIcon(iconCode); // 아이콘 강제 주간화

  static String _forceDayIcon(String code) {
    if (code.length != 3) return code;
    return code.substring(0, 2) + 'd'; // ex: '10n' → '10d'
  }
}
