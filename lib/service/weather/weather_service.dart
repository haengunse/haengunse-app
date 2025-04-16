import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';
import 'package:haengunse/service/weather/location.dart';
import 'package:haengunse/service/weather/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String _apiKey = Config.openWeatherApiKey;
  final String _baseUrl = Config.openWeatherApiBaseUrl;

  Future<Weather?> fetchWeather() async {
    print("🚀 fetchWeather 호출됨");
    final location = MyLocation();
    await location.getMyCurrentLocation();
    print("📍 위치: lat=${location.latitude}, lon=${location.longitude}");

    final url =
        '$_baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$_apiKey&units=metric&lang=kr';
    print("📡 날씨 요청 URL: $url");
    try {
      final response = await _dio.get(url);
      print('✅ 응답 코드: ${response.statusCode}');
      print('✅ 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        try {
          return Weather(
            cityId: data['id'],
            cityName: data['name'],
            condition: data['weather'][0]['description'],
            iconCode: data['weather'][0]['icon'],
            temp: data['main']['temp'].toDouble(),
            tempMin: data['main']['temp_min'].toDouble(),
            tempMax: data['main']['temp_max'].toDouble(),
            rainfall: data['rain']?['1h']?.toDouble() ??
                data['rain']?['3h']?.toDouble() ??
                data['snow']?['1h']?.toDouble() ??
                data['snow']?['3h']?.toDouble() ??
                0.0,
          );
        } catch (e) {
          print("❗ Weather 파싱 중 오류 발생: $e");
          return null;
        }
      } else {
        print('❗ 날씨 API 응답 오류: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❗ 날씨 API 호출 실패: $e');
      return null;
    }
  }
}
