import 'package:flutter/material.dart';
import 'package:haengunse/service/card/horoscope_fortune.dart';
import 'package:haengunse/screens/horoscope/horoscope_header_selector.dart';
import 'package:haengunse/screens/horoscope/horoscope_main_content.dart';
import 'package:haengunse/service/card/horoscope_calculator.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFortune.titleName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          HoroscopeHeaderSelector<T>(
            fortuneList: widget.fortuneList,
            selected: selectedFortune,
            onSelect: selectFortune,
            mode: widget.mode,
          ),
          Expanded(
            child: HoroscopeMainContent<T>(
              fortune: selectedFortune,
              mode: widget.mode,
            ),
          ),
        ],
      ),
    );
  }
}
