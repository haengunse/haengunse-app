import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';
import 'package:haengunse/screens/horoscope/horoscope_match_card.dart';

class HoroscopeMainContent<T extends BaseFortune> extends StatelessWidget {
  final T fortune;
  final HoroscopeMode mode;

  const HoroscopeMainContent({
    required this.fortune,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/${mode == HoroscopeMode.star ? 'star' : 'zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
            width: 150,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),

          // 날짜 범위 (HoroscopeMode.star일 때만)
          if (mode == HoroscopeMode.star && fortune is StarFortune)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                (fortune as StarFortune).dateRange,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),

          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Text(
              fortune.mainMessage,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HoroscopeMatchCard(
                label: '잘 맞는 친구',
                ageName: fortune.bestMatch,
                mode: mode,
              ),
              HoroscopeMatchCard(
                label: '주의할 친구',
                ageName: fortune.worstMatch,
                mode: mode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
