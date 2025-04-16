import 'package:flutter/material.dart';
import 'package:haengunse/service/weather/weather_model.dart';
import 'package:haengunse/service/weather/weather_service.dart';
import 'package:haengunse/utils/city_mapper.dart';

class SectionLucky extends StatefulWidget {
  final double screenHeight;
  final String userName;

  const SectionLucky({
    super.key,
    required this.screenHeight,
    required this.userName,
  });

  @override
  State<SectionLucky> createState() => _SectionLuckyState();
}

class _SectionLuckyState extends State<SectionLucky> {
  late Future<Weather?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    print('🚀 SectionLucky: initState 호출');
    _weatherFuture = WeatherService().fetchWeather();
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일";
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 도시명
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

              // 날씨 아이콘
              Image.network(
                'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),

              const SizedBox(width: 6),

              // 현재 온도
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

              // 최고 기온
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

              // 최저 기온
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

              // 강수량
              Text(
                weather.rainfall == 0
                    ? "강수량 없음"
                    : "강수량 ${weather.rainfall!.toStringAsFixed(1)}mm",
                style: const TextStyle(fontSize: 11, fontFamily: 'Pretendard'),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight / 3,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 244, 231),
      ),
      padding: const EdgeInsets.fromLTRB(24, 100, 5, 16),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Image.asset(
              "assets/images/home_main.png",
              width: 230,
              height: 230,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("반가워요 ${widget.userName}!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontFamily: 'Pretendard',
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/todaysplash');
                },
                child: const Text(
                  "오늘은\n어떤 하루일까요? ->",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Pretendard'),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _getTodayDate(),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontFamily: 'Pretendard'),
              ),
              const SizedBox(height: 13),
              FutureBuilder<Weather?>(
                  future: WeatherService().fetchWeather(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 340,
                        height: 35,
                        child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return _buildWeatherInfo(snapshot.data!);
                    } else {
                      return SizedBox(
                        width: 340,
                        height: 35,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
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
                                  color: Color.fromARGB(255, 105, 105, 105)),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
