class Weather {
  final int cityId;
  final String cityName;
  final String condition;
  final String iconCode;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double? rainfall;
  final double? rainAmount;
  final double? snowAmount;

  Weather({
    required this.cityId,
    required this.cityName,
    required this.condition,
    required this.iconCode,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    this.rainfall,
    this.rainAmount,
    this.snowAmount,
  });
  
  String get precipitationText {
    if ((rainAmount ?? 0) > 0 && (snowAmount ?? 0) > 0) {
      return "비+눈 ${rainfall?.toStringAsFixed(1)}mm";
    } else if ((rainAmount ?? 0) > 0) {
      return "강수량 ${rainfall?.toStringAsFixed(1)}mm";
    } else if ((snowAmount ?? 0) > 0) {
      return "적설량 ${rainfall?.toStringAsFixed(1)}mm";
    } else {
      return "강수량 없음";
    }
  }
}
