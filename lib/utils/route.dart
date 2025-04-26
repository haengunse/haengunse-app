import 'package:flutter/material.dart';
import 'package:haengunse/screens/onboarding/onboarding_screen.dart';
import 'package:haengunse/screens/today/%08today_loading_page.dart';
import 'package:haengunse/screens/card/star_screen.dart';
import 'package:haengunse/screens/card/zodiac_screen.dart';
import 'package:haengunse/screens/card/dream_screen.dart';
import 'package:haengunse/service/card/card_api.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case '/todaysplash':
        return MaterialPageRoute(
            builder: (_) => const TodayProgressLoadingPage());

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
