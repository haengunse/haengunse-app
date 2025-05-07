import 'package:flutter/material.dart';
import 'package:haengunse/service/card/card_api.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class CardInteractor {
  static Future<void> handleTap({
    required BuildContext context,
    required FortuneCardData card,
  }) async {
    await CardService.fetchCardData(
      context: context,
      route: card.route,
      onSuccess: (data) {
        if (!context.mounted) return;

        if (card.route == '/dream') {
          Navigator.pushNamed(context, card.route);
        } else if (card.route == '/saju') {
          final sajuData = data as Map<String, dynamic>;
          Navigator.pushNamed(
            context,
            card.route,
            arguments: {
              'manseInfo': sajuData['manseInfo'] ?? '',
              'sajuResult':
                  Map<String, String>.from(sajuData['sajuResult'] ?? {}),
              'userName': sajuData['userName'] ?? '이름없음',
            },
          );
        } else if (card.route == '/zodiac') {
          final fortuneList =
              (data as List).map((e) => ZodiacFortune.fromJson(e)).toList();
          Navigator.pushNamed(
            context,
            card.route,
            arguments: fortuneList,
          );
        } else if (card.route == '/star') {
          final fortuneList =
              (data as List).map((e) => StarFortune.fromJson(e)).toList();
          Navigator.pushNamed(
            context,
            card.route,
            arguments: fortuneList,
          );
        }
      },
      retry: () => handleTap(context: context, card: card),
    );
  }
}
