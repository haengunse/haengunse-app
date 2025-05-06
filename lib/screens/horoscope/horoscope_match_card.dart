import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeMatchCard extends StatelessWidget {
  final String label;
  final String ageName;
  final HoroscopeMode mode;

  const HoroscopeMatchCard({
    required this.label,
    required this.ageName,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[ageName] : koreanToZodiacEnglish[ageName]}.png',
          width: 60,
          height: 60,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            ageName,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
