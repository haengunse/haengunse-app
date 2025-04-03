import 'package:flutter/material.dart';
import 'package:haengunse/screens/day/random_screen.dart';
import 'package:haengunse/screens/day/cookie_screen.dart';
import 'package:haengunse/screens/day/item_screen.dart';
import 'package:haengunse/service/day/day_api.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:haengunse/config.dart';

class DayUiService {
  static Future<void> handleRandomTap(
      BuildContext context, Function(Widget) showDialog) async {
    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageRandomUrl),
      onSuccess: (answer) => showDialog(RandomScreen(answer: answer)),
      retry: () => handleRandomTap(context, showDialog),
    );
  }

  static Future<void> handleCookieTap(
      BuildContext context, Function(Widget) showDialog) async {
    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageCookieUrl),
      onSuccess: (answer) => showDialog(CookieScreen(answer: answer)),
      retry: () => handleCookieTap(context, showDialog),
    );
  }

  static Future<void> handleItemTap(
      BuildContext context, Function(Widget) showDialog) async {
    handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () => DayService.fetchItem(Config.messageItemUrl),
      onSuccess: (item) => showDialog(ItemScreen(item: item)),
      retry: () => handleItemTap(context, showDialog),
    );
  }
}
