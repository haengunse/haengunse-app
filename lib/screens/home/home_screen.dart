import 'package:flutter/material.dart';
import 'package:haengunse/screens/onboarding/input_screen.dart';
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

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const InputScreen()),
      (route) => false,
    );
  }

  void _showLicense() {
    showLicensePage(
      context: context,
      applicationName: '행운세',
      applicationVersion: '1.0.0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // AppBar가 body 위에 그려지도록
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 244, 231),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 95, 192, 108),
              ),
              child: Text(
                'MENU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('내 정보 수정'),
              onTap: () {
                Navigator.pop(context); // drawer 먼저 닫기
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InputScreen(showBackButton: true),
                    ),
                  );
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('정보 삭제'),
              onTap: _clearUserData,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('오픈소스 라이선스'),
              onTap: _showLicense,
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionLucky(userName: userName),
              const SectionCard(),
              const SectionDay(),
            ],
          ),
        ),
      ),
    );
  }
}
