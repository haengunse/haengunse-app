import 'package:flutter/material.dart';
import 'package:haengunse/service/card/card_api.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';
import 'package:haengunse/utils/interstitial_ad_helper.dart';

class CardInteractor {
  static Future<void> handleTap({
    required BuildContext context,
    required FortuneCardData card,
  }) async {
    // 사주 화면의 경우 API 요청과 동시에 전면 광고 표시
    if (card.route == '/saju') {
      bool isDataReady = false;
      Map<String, dynamic>? sajuData;
      bool hasNavigated = false;
      
      // 먼저 API 요청 시작
      CardService.fetchCardData(
        context: context,
        route: card.route,
        onSuccess: (data) {
          sajuData = data as Map<String, dynamic>;
          isDataReady = true;
          
          // 데이터가 준비되었을 때 광고가 이미 끝났다면 바로 이동
          if (!hasNavigated && context.mounted) {
            hasNavigated = true;
            Navigator.pushNamed(
              context,
              card.route,
              arguments: {
                'manseInfo': sajuData!['manseInfo'] ?? '',
                'sajuResult':
                    Map<String, String>.from(sajuData!['sajuResult'] ?? {}),
                'userName': sajuData!['userName'] ?? '이름없음',
              },
            );
          }
        },
        retry: () => handleTap(context: context, card: card),
      );
      
      // 동시에 광고 표시
      InterstitialAdHelper.showInterstitialAd(
        onAdDismissed: () {
          // 광고가 끝났을 때 데이터가 준비되었으면 바로 페이지 이동
          if (isDataReady && !hasNavigated && context.mounted) {
            hasNavigated = true;
            Navigator.pushNamed(
              context,
              card.route,
              arguments: {
                'manseInfo': sajuData!['manseInfo'] ?? '',
                'sajuResult':
                    Map<String, String>.from(sajuData!['sajuResult'] ?? {}),
                'userName': sajuData!['userName'] ?? '이름없음',
              },
            );
          }
          // 데이터가 아직 준비되지 않았으면 CardService의 로딩이 계속됨
        },
      );
      return;
    }

    // 다른 화면들은 기존 로직 유지
    await CardService.fetchCardData(
      context: context,
      route: card.route,
      onSuccess: (data) {
        if (!context.mounted) return;

        if (card.route == '/dream') {
          // 먼저 페이지로 이동
          Navigator.pushNamed(context, card.route);
          // 약간의 딜레이 후 광고 표시
          Future.delayed(const Duration(milliseconds: 300), () {
            InterstitialAdHelper.showInterstitialAd();
          });
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
