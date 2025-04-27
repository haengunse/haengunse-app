import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeMainScreen<T extends BaseFortune> extends StatefulWidget {
  final List<T> fortuneList;
  final HoroscopeMode mode;

  const HoroscopeMainScreen({
    super.key,
    required this.fortuneList,
    required this.mode,
  });

  @override
  State<HoroscopeMainScreen<T>> createState() => _HoroscopeMainScreenState<T>();
}

class _HoroscopeMainScreenState<T extends BaseFortune>
    extends State<HoroscopeMainScreen<T>> {
  late T selectedFortune;

  @override
  void initState() {
    super.initState();
    selectedFortune = widget.fortuneList.first;
  }

  void selectFortune(T fortune) {
    setState(() {
      selectedFortune = fortune;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedFortune.titleName, // 서버 한글 응답 그대로 사용
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _HeaderSelector<T>(
            fortuneList: widget.fortuneList,
            selected: selectedFortune,
            onSelect: selectFortune,
            mode: widget.mode,
          ),
          Expanded(
            child: _MainContent<T>(
              fortune: selectedFortune,
              mode: widget.mode,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────

// 상단 버튼 스크롤
class _HeaderSelector<T extends BaseFortune> extends StatelessWidget {
  final List<T> fortuneList;
  final T selected;
  final Function(T) onSelect;
  final HoroscopeMode mode;

  const _HeaderSelector({
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
                    fortune.titleName, // 한글 그대로
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

// ─────────────────────────────────────

// 메인 컨텐츠
class _MainContent<T extends BaseFortune> extends StatelessWidget {
  final T fortune;
  final HoroscopeMode mode;

  const _MainContent({
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
            height: 150,
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
              _MatchCard(
                label: '잘 맞는 친구',
                ageName: fortune.bestMatch,
                mode: mode,
              ),
              _MatchCard(
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

// ─────────────────────────────────────

// 매칭 카드
class _MatchCard extends StatelessWidget {
  final String label;
  final String ageName;
  final HoroscopeMode mode;

  const _MatchCard({
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
            ageName, // 한글 그대로
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
