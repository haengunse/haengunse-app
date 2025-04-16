import 'package:flutter/material.dart';
import 'package:haengunse/service/weather/weather_model.dart';
import 'package:haengunse/service/weather/weather_service.dart';
import 'package:haengunse/utils/city_mapper.dart';

class WeatherBox extends StatefulWidget {
  const WeatherBox({super.key});

  @override
  State<WeatherBox> createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  late Future<Weather?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather?>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 340,
            height: 35,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return _buildWeatherInfo(snapshot.data!);
        } else {
          return _buildErrorBox();
        }
      },
    );
  }

  Widget _buildErrorBox() {
    return SizedBox(
      width: 340,
      height: 35,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "날씨 정보를 불러오지 못했습니다.",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Pretendard',
              color: Color.fromARGB(255, 105, 105, 105),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(Weather weather) {
    return SizedBox(
      width: 340,
      height: 35,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  CityMapper.getKoreanCityById(weather.cityId),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 10),
                const Text("|"),
                const SizedBox(width: 6),
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 6),
                Text(
                  "${weather.temp.toInt()}°",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 6),
                const Text("|"),
                const SizedBox(width: 10),
                Text(
                  "최고 ",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${weather.tempMax.toInt()}°",
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 6),
                const Text("|"),
                const SizedBox(width: 10),
                Text(
                  "최저 ",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "${weather.tempMin.toInt()}°",
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 6),
                const Text("|"),
                const SizedBox(width: 10),
                Text(
                  weather.rainfall == 0
                      ? "강수량 없음"
                      : "강수량 ${weather.rainfall!.toStringAsFixed(1)}mm",
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Pretendard',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
