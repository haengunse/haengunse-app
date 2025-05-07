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
    required this.iconCode,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    this.rainfall,
  });
}
