import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeHeaderSelector<T extends BaseFortune> extends StatelessWidget {
  final List<T> fortuneList;
  final T selected;
  final Function(T) onSelect;
  final HoroscopeMode mode;

  const HoroscopeHeaderSelector({
    required this.fortuneList,
    required this.selected,
    required this.onSelect,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fortuneList.length,
        itemBuilder: (context, index) {
          final fortune = fortuneList[index];
          final isSelected = fortune.titleName == selected.titleName;

          return GestureDetector(
            onTap: () => onSelect(fortune),
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.yellow[100] : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fortune.titleName,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
