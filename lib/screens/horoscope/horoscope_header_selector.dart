import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeHeaderSelector<T extends BaseFortune> extends StatefulWidget {
  final List<T> fortuneList;
  final T selected;
  final Function(T) onSelect;
  final HoroscopeMode mode;
  final String viewAllLabel;

  const HoroscopeHeaderSelector({
    Key? key,
    required this.fortuneList,
    required this.selected,
    required this.onSelect,
    required this.mode,
    required this.viewAllLabel,
  }) : super(key: key);

  @override
  State<HoroscopeHeaderSelector<T>> createState() =>
      _HoroscopeHeaderSelectorState<T>();
}

class _HoroscopeHeaderSelectorState<T extends BaseFortune>
    extends State<HoroscopeHeaderSelector<T>> {
  bool _isExpanded = false;

  static const double _itemWidth = 84;
  static const double _itemMarginHorizontal = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isExpanded)
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.viewAllLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'pretendard',
                    color: Colors.grey[900],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_up, color: Colors.grey[900]),
                  onPressed: () => setState(() => _isExpanded = false),
                ),
              ],
            ),
          ),

        // 헤더
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: _isExpanded
              ? _buildGridFullView() // 전체가 보이도록 자동 높이 설정
              : Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    _buildHorizontalList(),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey[900]),
                        onPressed: () => setState(() => _isExpanded = true),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 8, right: 16),
        itemCount: widget.fortuneList.length,
        itemBuilder: (context, index) {
          final fortune = widget.fortuneList[index];
          final isSelected = fortune.titleName == widget.selected.titleName;
          return _buildItem(fortune, isSelected);
        },
      ),
    );
  }

  Widget _buildGridFullView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // SingleChildScrollView로 감싸기 전제
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0), // 마지막 줄과 화살표 거리 확보
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        children: widget.fortuneList.map((fortune) {
          final isSelected = fortune.titleName == widget.selected.titleName;
          return _buildItem(fortune, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildItem(T fortune, bool isSelected) {
    return GestureDetector(
      onTap: () => widget.onSelect(fortune),
      child: Container(
        width: _itemWidth,
        margin: const EdgeInsets.symmetric(
          horizontal: _itemMarginHorizontal,
          vertical: 6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/${widget.mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${widget.mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
              width: 44,
              height: 44,
            ),
            const SizedBox(height: 6),
            Text(
              fortune.titleName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'HakgyoansimDunggeunmiso',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
