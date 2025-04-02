import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';
import '../screens/input_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/today_screen.dart';
import '../screens/card/star_screen.dart';
import '../screens/card/zodiac_screen.dart';
import '../screens/card/dream_screen.dart';
import 'package:haengunse/service/card_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => FutureBuilder<bool>(
            future: SharedPreferences.getInstance().then((prefs) {
              prefs.clear(); // 테스트 초기화
              return prefs.getBool('isFirstRun') ?? true;
            }),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              return snapshot.data! ? const InputScreen() : const HomeScreen();
            },
          ),
        );
      case '/today':
        return MaterialPageRoute(builder: (_) => const TodayScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case CardRoute.star:
        return MaterialPageRoute(builder: (_) => const StarScreen());
      case CardRoute.zodiac:
        return MaterialPageRoute(builder: (_) => const ZodiacScreen());
      case CardRoute.dream:
        return MaterialPageRoute(builder: (_) => const DreamScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
