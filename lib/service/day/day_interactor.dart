import 'package:flutter/material.dart';
import 'package:haengunse/screens/day/random_screen.dart';
import 'package:haengunse/screens/day/cookie_screen.dart';
import 'package:haengunse/screens/day/item_screen.dart';
import 'package:haengunse/service/day/day_api.dart';
import 'package:haengunse/service/day/day_cache_storage.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:haengunse/config.dart';

class DayInteractor {
  static Future<void> handleRandomTap(
      BuildContext context, Function(Widget) showDialog) async {
    // 캐시된 데이터 확인
    final cachedMessage = await DayCacheStorage.loadRandomMessage();
    if (cachedMessage != null) {
      showDialog(RandomScreen(message: cachedMessage));
      return;
    }

    // 캐시가 없으면 서버 요청
    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageRandomUrl),
      onSuccess: (message) async {
        await DayCacheStorage.saveRandomMessage(message);
        showDialog(RandomScreen(message: message));
      },
      retry: () => handleRandomTap(context, showDialog),
    );
  }

  static Future<void> handleCookieTap(
      BuildContext context, Function(Widget) showDialog) async {
    // 캐시된 데이터 확인
    final cachedMessage = await DayCacheStorage.loadCookieMessage();
    if (cachedMessage != null) {
      showDialog(CookieScreen(message: cachedMessage));
      return;
    }

    // 캐시가 없으면 서버 요청
    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageCookieUrl),
      onSuccess: (message) async {
        await DayCacheStorage.saveCookieMessage(message);
        showDialog(CookieScreen(message: message));
      },
      retry: () => handleCookieTap(context, showDialog),
    );
  }

  static Future<void> handleItemTap(
      BuildContext context, Function(Widget) showDialog) async {
    // 캐시된 데이터 확인
    final cachedItem = await DayCacheStorage.loadItemData();
    if (cachedItem != null) {
      showDialog(ItemScreen(item: cachedItem));
      return;
    }

    // 캐시가 없으면 서버 요청
    handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () => DayService.fetchItem(Config.messageItemUrl),
      onSuccess: (item) async {
        await DayCacheStorage.saveItemData(item);
        showDialog(ItemScreen(item: item));
      },
      retry: () => handleItemTap(context, showDialog),
    );
  }
}
