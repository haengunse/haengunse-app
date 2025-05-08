import 'package:flutter/material.dart';
import 'package:haengunse/screens/card/dream_screen.dart';
import 'package:haengunse/screens/card/saju_screen.dart';
import 'package:haengunse/screens/card/star_screen.dart';
import 'package:haengunse/screens/card/zodiac_screen.dart';
import 'package:haengunse/screens/onboarding/onboarding_screen.dart';
import 'package:haengunse/screens/onboarding/privacy_screen.dart';
import 'package:haengunse/screens/onboarding/terms_screen.dart';
import 'package:haengunse/screens/today/today_loading_page.dart';
import 'package:haengunse/service/card/card_api.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case '/todaysplash':
        return MaterialPageRoute(
          builder: (_) => const TodayProgressLoadingPage(),
        );

      case CardRoute.star:
        if (settings.arguments != null &&
            settings.arguments is List<StarFortune>) {
          final fortuneList = settings.arguments as List<StarFortune>;
          return MaterialPageRoute(
            builder: (_) => StarScreen(fortuneList: fortuneList),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('잘못된 별자리 접근')),
            ),
          );
        }

      case CardRoute.zodiac:
        if (settings.arguments != null &&
            settings.arguments is List<ZodiacFortune>) {
          final fortuneList = settings.arguments as List<ZodiacFortune>;
          return MaterialPageRoute(
            builder: (_) => ZodiacScreen(fortuneList: fortuneList),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('잘못된 띠운세 접근')),
            ),
          );
        }

      case CardRoute.dream:
        return MaterialPageRoute(
          builder: (_) => const DreamScreen(),
        );

      case CardRoute.saju:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;

          final sajuResultRaw = args['sajuResult'];
          final sajuResult = sajuResultRaw is Map
              ? sajuResultRaw.map<String, String>(
                  (key, value) => MapEntry(key.toString(), value.toString()))
              : <String, String>{};

          return MaterialPageRoute(
            builder: (_) => SajuScreen(
              manseInfo: args['manseInfo'] ?? '',
              sajuResult: sajuResult,
              userName: args['userName'] ?? '이름없음',
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('잘못된 접근입니다.')),
            ),
          );
        }

      case '/terms':
        return MaterialPageRoute(
          builder: (_) => const TermsScreen(),
        );

      case '/privacy':
        return MaterialPageRoute(
          builder: (_) => const PrivacyScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
