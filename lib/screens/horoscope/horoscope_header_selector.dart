import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';

class HoroscopeHeaderSelector<T extends BaseFortune> extends StatefulWidget {
  final List<T> fortuneList;
  final T selected;
  final Function(T) onSelect;
  final HoroscopeMode mode;
  final String viewAllLabel;
  final Function(bool)? onExpandChanged;

  const HoroscopeHeaderSelector({
    Key? key,
    required this.fortuneList,
    required this.selected,
    required this.onSelect,
    required this.mode,
    required this.viewAllLabel,
    this.onExpandChanged,
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

  void _toggleExpand(bool expand) {
    setState(() => _isExpanded = expand);
    widget.onExpandChanged?.call(expand); // 외부 전달
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isExpanded)
          Container(
            color: Colors.white,
            child: Padding(
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
                      fontFamily: 'HakgyoansimDunggeunmiso',
                      color: Colors.grey[900],
                    ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.keyboard_arrow_up, color: Colors.grey[900]),
                    onPressed: () => _toggleExpand(false),
                  ),
                ],
              ),
            ),
          ),

        // 헤더
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[400] ?? Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey[400] ?? Colors.grey, width: 0.5),
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
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white.withOpacity(0.0), // 투명
                              Colors.white.withOpacity(0.8), // 중간
                              Colors.white, // 완전 흰색
                            ],
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey[900]),
                          onPressed: () => _toggleExpand(true),
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
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 16.w),
          itemCount: widget.fortuneList.length,
          itemBuilder: (context, index) {
            final fortune = widget.fortuneList[index];
            final isSelected = fortune.titleName == widget.selected.titleName;
            final isFirst = index == 0;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: _buildItem(fortune, isSelected, removeMargin: isFirst),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFixedGridView() {
    const int columns = 4;
    const int rows = 3;
    final double itemHeight = 90.h;
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
          return _buildItem(fortune, isSelected, removeMargin: true);
        }).toList(),
      ),
    );
  }

  Widget _buildItem(T fortune, bool isSelected, {bool removeMargin = false}) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(fortune);
        if (_isExpanded) {
          _toggleExpand(false);
        }
      },
      child: Container(
        width: _itemWidth.w,
        margin: removeMargin
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: _itemMarginHorizontal.w),
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
                height: 1.sp,
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
