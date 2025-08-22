import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/weather/weather_model.dart';
import 'package:haengunse/service/weather/weather_service.dart';
import 'package:haengunse/utils/city_mapper.dart';

class WeatherBox extends StatefulWidget {
  const WeatherBox({super.key});

  @override
  State<WeatherBox> createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> with WidgetsBindingObserver {
  late Future<Weather?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchWeather();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _fetchWeather();
    }
  }

  void _fetchWeather() {
    setState(() {
      _weatherFuture = WeatherService().fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather?>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 340.w,
            height: 35.h,
            child: const Center(
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
      width: 340.w,
      height: 35.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5.r,
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 345.w,
        maxHeight: 34.h,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text(
                    CityMapper.getCityName(
                      cityId: weather.cityId,
                      fallbackName: weather.cityName,
                    ),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text("|", style: TextStyle(color: const Color(0xFF777777))),
                  SizedBox(width: 8.w),
                  Image.asset(
                    'assets/images/weather/${weather.iconCode}.png',
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${weather.temp.toInt()}°",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black87,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text("|", style: TextStyle(color: const Color(0xFF777777))),
                  SizedBox(width: 8.w),
                  Text(
                    "최고",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${weather.tempMax.toInt()}°",
                    style: TextStyle(fontSize: 11.sp, fontFamily: 'Pretendard'),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "최저",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.blue[400],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${weather.tempMin.toInt()}°",
                    style: TextStyle(fontSize: 11.sp, fontFamily: 'Pretendard'),
                  ),
                  SizedBox(width: 7.w),
                  Text("|", style: TextStyle(color: const Color(0xFF777777))),
                  SizedBox(width: 8.w),
                  Text(
                    (weather.rainfall == null || weather.rainfall == 0)
                        ? "강수량 없음"
                        : "강수량 ${weather.rainfall!.toStringAsFixed(1)}mm",
                    style: TextStyle(fontSize: 11.sp, fontFamily: 'Pretendard'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
