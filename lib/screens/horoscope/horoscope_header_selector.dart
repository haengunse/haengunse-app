import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                EdgeInsets.only(left: 12.w, right: 12.w, top: 4.h, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.viewAllLabel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
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
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[400]!, width: 0.5),
              bottom: BorderSide(color: Colors.grey[400]!, width: 0.5),
            ),
          ),
          child: _isExpanded
              ? _buildFixedGridView()
              : Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    _buildHorizontalList(),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 44.w,
                        color: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey[900]),
                          onPressed: () => setState(() => _isExpanded = true),
                        ),
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
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 8.w, right: 48.w),
        itemCount: widget.fortuneList.length,
        itemBuilder: (context, index) {
          final fortune = widget.fortuneList[index];
          final isSelected = fortune.titleName == widget.selected.titleName;
          return _buildItem(fortune, isSelected);
        },
      ),
    );
  }

  Widget _buildFixedGridView() {
    const int columns = 4;
    const int rows = 3;
    final double itemHeight = 85.h;
    final double spacing = 5.h;
    final double totalHeight =
        (itemHeight * rows) + (spacing * (rows - 1)) + 5.h;

    return SizedBox(
      height: totalHeight,
      child: GridView.count(
        crossAxisCount: columns,
        childAspectRatio: _itemWidth.w / itemHeight,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
        mainAxisSpacing: spacing,
        crossAxisSpacing: 16.w,
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
        width: _itemWidth.w,
        margin: EdgeInsets.symmetric(
          horizontal: _itemMarginHorizontal.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/${widget.mode == HoroscopeMode.star ? 'character_star' : 'character_zodiac'}/${widget.mode == HoroscopeMode.star ? koreanToHoroscopeEnglish[fortune.titleName] : koreanToZodiacEnglish[fortune.titleName]}.png',
              width: 44.w,
              height: 44.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 6.h),
            Text(
              fortune.titleName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.1,
                fontFamily: 'HakgyoansimDunggeunmiso',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            if (isSelected)
              Container(
                width: 60.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
