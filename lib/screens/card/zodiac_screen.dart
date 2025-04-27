import 'package:flutter/material.dart';
import 'package:haengunse/screens/horoscope/horoscope_main_screen.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class ZodiacScreen extends StatelessWidget {
  final List<ZodiacFortune> fortuneList;

  const ZodiacScreen({super.key, required this.fortuneList});

  @override
  Widget build(BuildContext context) {
    return HoroscopeMainScreen<ZodiacFortune>(
      fortuneList: fortuneList,
      mode: HoroscopeMode.zodiac,
    );
  }
}
