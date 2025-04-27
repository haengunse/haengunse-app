import 'package:flutter/material.dart';
import 'package:haengunse/screens/horoscope/horoscope_main_screen.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class StarScreen extends StatelessWidget {
  final List<StarFortune> fortuneList;

  const StarScreen({super.key, required this.fortuneList});

  @override
  Widget build(BuildContext context) {
    return HoroscopeMainScreen<StarFortune>(
      fortuneList: fortuneList,
      mode: HoroscopeMode.star,
    );
  }
}
