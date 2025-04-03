import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haengunse/config.dart';
import 'package:haengunse/utils/request_helper.dart';

class FortuneCardData {
  final String imagePath;
  final String smallTitle;
  final String bigTitle;
  final String route;

  FortuneCardData({
    required this.imagePath,
    required this.smallTitle,
    required this.bigTitle,
    required this.route,
  });
}

class CardRoute {
  static const String star = '/star';
  static const String zodiac = '/zodiac';
  static const String dream = '/dream';
}

class CardService {
  static Future<List<FortuneCardData>> fetchFortuneCards() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      FortuneCardData(
        imagePath: 'assets/images/fortune_star.png',
        smallTitle: '별이 건네는 이야기',
        bigTitle: '별자리 운세',
        route: CardRoute.star,
      ),
      FortuneCardData(
        imagePath: 'assets/images/fortune_zodiac.png',
        smallTitle: '열두 띠의 하루',
        bigTitle: '띠 운세',
        route: CardRoute.zodiac,
      ),
      FortuneCardData(
        imagePath: 'assets/images/fortune_dream.png',
        smallTitle: '꿈이 알려주는 마음의 신호',
        bigTitle: '꿈 해몽',
        route: CardRoute.dream,
      ),
    ];
  }

  static Future<void> fetchCardData({
    required BuildContext context,
    required String route,
    required void Function() onSuccess,
    required VoidCallback retry,
  }) async {
    if (route == CardRoute.dream) {
      onSuccess();
      return;
    }

    String? uri;
    switch (route) {
      case CardRoute.star:
        uri = Config.starApiUrl;
        break;
      case CardRoute.zodiac:
        uri = Config.zodiacApiUrl;
        break;
    }

    await handleRequest(
      context: context,
      fetch: () async {
        final dio = Dio();
        final response = await dio.get(uri!);
        debugPrint("응답 데이터: \${response.data}");

        if (response.statusCode == 200) {
          final data = response.data;
          if (data is List && data.isNotEmpty) {
            final firstItem = data[0];
            debugPrint("mainMessage: \${firstItem['content']['mainMessage']}");
            return true;
          }
        }

        throw Exception('데이터 형식 오류 또는 빈 데이터');
      },
      onSuccess: (_) => onSuccess(),
      retry: retry,
    );
  }
}
