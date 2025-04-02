import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/home/lucky_section.dart';
import 'package:haengunse/screens/home/card_section.dart';
import 'package:haengunse/screens/home/day_section.dart';

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
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? "행운세";
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
          SectionCard(screenHeight: screenHeight), //여기 수정할 것
          SectionDay(screenHeight: screenHeight), //여기 수정할 것
        ],
      ),
    );
  }
}
