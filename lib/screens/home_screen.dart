import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/home/lucky_section.dart';
import 'package:haengunse/screens/home/card_section.dart';
import 'package:haengunse/screens/home/day_section.dart';
import 'package:haengunse/utils/city_mapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "행운세";

  @override
  void initState() {
    super.initState();
    _initCityMap();
    _loadUserData();
  }

  Future<void> _initCityMap() async {
    await CityMapper.loadCityMap();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name') ?? "행운세";
    final gender = prefs.getString('gender') ?? "모름";
    final manseInfo = prefs.getString('manseInfo') ?? "없음";

    debugPrint("이름: $name");
    debugPrint("성별: $gender");
    debugPrint("만세력: $manseInfo");

    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Column(
        children: [
          SectionLucky(userName: userName, screenHeight: screenHeight),
          SectionCard(screenHeight: screenHeight),
          SectionDay(screenHeight: screenHeight),
        ],
      ),
    );
  }
}
