import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';
import 'package:haengunse/screens/horoscope/horoscope_header_selector.dart';
import 'package:haengunse/screens/horoscope/horoscope_main_content.dart';
import 'package:haengunse/service/card/horoscope_calculator.dart';
import 'package:haengunse/widgets/banner_ad_widget.dart';

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
  T? selectedFortune; // nullable 처리
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _initSelectedFortune();
  }

  Future<void> _initSelectedFortune() async {
    String? titleName;

    if (widget.mode == HoroscopeMode.star) {
      titleName = await HoroscopeCalculator.getStarSign();
    } else {
      titleName = await HoroscopeCalculator.getZodiacAnimal();
    }

    final matched = widget.fortuneList.firstWhere(
      (f) => f.titleName == titleName,
      orElse: () => widget.fortuneList.first,
    );

    setState(() {
      selectedFortune = matched;
    });
  }

  void selectFortune(T fortune) {
    setState(() {
      selectedFortune = fortune;
    });
  }

  void handleExpandChange(bool expanded) {
    setState(() {
      isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedFortune == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          selectedFortune!.titleName,
          style: TextStyle(
            fontFamily: 'HakgyoansimDunggeunmiso',
            fontWeight: FontWeight.w400,
            fontSize: 23.sp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.w),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: isExpanded,
            child: Opacity(
              opacity: isExpanded ? 0.4 : 1.0,
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Expanded(
                    child: HoroscopeMainContent<T>(
                      fortune: selectedFortune!,
                      mode: widget.mode,
                    ),
                  ),
                  const BannerAdWidget(isLargeBanner: true),
                ],
              ),
            ),
          ),
          Column(
            children: [
              HoroscopeHeaderSelector<T>(
                fortuneList: widget.fortuneList,
                selected: selectedFortune!,
                onSelect: selectFortune,
                mode: widget.mode,
                viewAllLabel: '모두 펼치기',
                onExpandChanged: handleExpandChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
