import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/splash_screen.dart';
import 'package:haengunse/screens/error_page.dart';
import 'package:haengunse/service/today/today_repository.dart';

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

    try {
      await TodayRepository.fetchToday(jsonData);
      // 성공 시 SplashScreen에서 내부적으로 Today 화면으로 전환될 것
    } catch (e) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ErrorPage(
              title: "오늘의 운세 요청 실패",
              message: "서버에 문제가 있거나 응답이 지연되고 있어요.",
              errorType: ErrorType.serverError,
              onRetry: null,
            ),
          ),
        );
      }
    }
  }
}
