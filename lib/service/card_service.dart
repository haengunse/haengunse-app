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
    // TODO: Replace with Dio/http call if using API
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      FortuneCardData(
        imagePath: 'assets/images/fortune_star.png',
        smallTitle: '별이 건네는 이야기',
        bigTitle: '별자리 운세',
        route: '/star',
      ),
      FortuneCardData(
        imagePath: 'assets/images/fortune_zodiac.png',
        smallTitle: '열두 띠의 하루',
        bigTitle: '띠 운세',
        route: '/zodiac',
      ),
      FortuneCardData(
        imagePath: 'assets/images/fortune_dream.png',
        smallTitle: '꿈이 알려주는 마음의 신호',
        bigTitle: '꿈 해몽',
        route: '/dream',
      ),
    ];
  }
}
