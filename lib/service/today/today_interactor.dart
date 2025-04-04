import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/service/today/today_repository.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:haengunse/screens/splash_screen.dart';
import 'package:haengunse/screens/today_screen.dart';

class TodayInteractor {
  static Future<void> handleTodayRequest(
      BuildContext context, String userName) async {
    final prefs = await SharedPreferences.getInstance();

    final birthDate = prefs.getString('birthDate');
    final solar = prefs.getString('solar');
    final birthTime = prefs.getString('birthTime');
    final gender = prefs.getString('gender');

    if ([birthDate, solar, birthTime, gender, userName].contains(null) ||
        userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("유저 정보가 누락되어 요청할 수 없습니다.")),
      );
      return;
    }

    final jsonData = {
      'birthDate': birthDate,
      'solar': solar,
      'birthTime': birthTime,
      'gender': gender,
      'name': userName,
    };

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SplashScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

    await handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () => TodayRepository.fetchToday(jsonData),
      onSuccess: (responseData) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => TodayScreen(
              requestData: jsonData,
              responseData: responseData,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      retry: () => handleTodayRequest(context, userName),
    );
  }
}
