import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';
import 'package:haengunse/service/weather/location.dart';
import 'package:haengunse/service/weather/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String _apiKey = Config.openWeatherApiKey;
  final String _baseUrl = Config.openWeatherApiBaseUrl;

  Future<Weather?> fetchWeather() async {
    final location = MyLocation();
    await location.getMyCurrentLocation();

    final url =
        '$_baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$_apiKey&units=metric&lang=kr';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        try {
          // 강수량 정보 상세 로깅
          final rainData = data['rain'];
          final snowData = data['snow'];
          
          print('[WeatherService] 🌧️ 비 데이터: $rainData');
          print('[WeatherService] ❄️ 눈 데이터: $snowData');
          
          // 비 강수량 (1시간 또는 3시간)
          final rain1h = rainData?['1h']?.toDouble();
          final rain3h = rainData?['3h']?.toDouble();
          
          // 눈 강수량 (1시간 또는 3시간)  
          final snow1h = snowData?['1h']?.toDouble();
          final snow3h = snowData?['3h']?.toDouble();
          
          // 총 강수량 계산 (비 + 눈)
          final totalRainfall = (rain1h ?? rain3h ?? 0.0) + (snow1h ?? snow3h ?? 0.0);
          
          print('[WeatherService] ☔ 비 1h: ${rain1h ?? "없음"}mm, 3h: ${rain3h ?? "없음"}mm');
          print('[WeatherService] ❄️ 눈 1h: ${snow1h ?? "없음"}mm, 3h: ${snow3h ?? "없음"}mm');
          print('[WeatherService] 🌦️ 총 강수량: ${totalRainfall}mm');

          return Weather(
            cityId: data['id'],
            cityName: data['name'],
            condition: data['weather'][0]['description'],
            iconCode: data['weather'][0]['icon'],
            temp: data['main']['temp'].toDouble(),
            tempMin: data['main']['temp_min'].toDouble(),
            tempMax: data['main']['temp_max'].toDouble(),
            rainfall: totalRainfall,
            rainAmount: rain1h ?? rain3h,
            snowAmount: snow1h ?? snow3h,
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
