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
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fortuneList.length,
        itemBuilder: (context, index) {
          final fortune = fortuneList[index];
          final isSelected = fortune.titleName == selected.titleName;

          return GestureDetector(
            onTap: () => onSelect(fortune),
            child: Container(
              width: 84,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/${mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    fortune.titleName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'HakgyoansimDunggeunmiso',
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.black, // 검정 밑줄
                        borderRadius: BorderRadius.circular(2),
                      ),
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
