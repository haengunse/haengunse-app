import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haengunse/config.dart';
import 'package:haengunse/screens/card/saju_loading_page.dart';
import 'package:haengunse/screens/card/saju_screen.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static const String saju = '/saju';
}

class CardService {
  static Future<List<FortuneCardData>> fetchFortuneCards() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      FortuneCardData(
        imagePath: 'assets/images/fortune.png',
        smallTitle: '사주로 보는 나만의 흐름',
        bigTitle: '사주 운세',
        route: CardRoute.saju,
      ),
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

    if (route == CardRoute.saju) {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5), // 전체 화면 반투명
        transitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const SajuLoadingPage();
        },
      );

      try {
        final prefs = await SharedPreferences.getInstance();
        final manseInfo = prefs.getString('manseInfo') ?? '';
        final gender = prefs.getString('gender') ?? 'M';

        final dio = Dio();
        final response = await dio.post(Config.sajuApiUrl, data: {
          "manseInfo": manseInfo,
          "gender": gender,
        });

        if (context.mounted) Navigator.pop(context); // 로딩 닫기

        if (response.statusCode == 200 && response.data['text'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SajuScreen(
                manseInfo: manseInfo,
                resultText: response.data['text'],
              ),
            ),
          );
        } else {
          throw Exception("응답 형식 오류");
        }
      } catch (e) {
        if (context.mounted) Navigator.pop(context);
        retry();
      }

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
        debugPrint("응답 데이터: ${response.data}");

        if (response.statusCode == 200) {
          final data = response.data;
          if (data is List && data.isNotEmpty) {
            final firstItem = data[0];
            debugPrint("mainMessage: ${firstItem['content']['mainMessage']}");
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
