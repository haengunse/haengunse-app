import 'package:flutter/material.dart';
import 'package:haengunse/service/card/card_api.dart';

class CardInteractor {
  static Future<void> handleTap({
    required BuildContext context,
    required String route,
  }) async {
    await CardService.fetchCardData(
      context: context,
      route: route,
      onSuccess: () {
        if (context.mounted) {
          Navigator.pushNamed(context, route);
        }
      },
      retry: () => handleTap(context: context, route: route),
    );
  }
}
