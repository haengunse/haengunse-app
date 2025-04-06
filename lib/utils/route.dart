import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/home_screen.dart';
import 'package:haengunse/screens/input_screen.dart';
import 'package:haengunse/screens/splash_screen.dart';
import 'package:haengunse/screens/today_screen.dart';
import 'package:haengunse/screens/card/star_screen.dart';
import 'package:haengunse/screens/card/zodiac_screen.dart';
import 'package:haengunse/screens/card/dream_screen.dart';
import 'package:haengunse/service/card/card_api.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => FutureBuilder<bool>(
            future: SharedPreferences.getInstance().then((prefs) {
              prefs.clear(); // <- 테스트 시에만 사용
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
