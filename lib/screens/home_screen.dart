import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/home/session_lucky.dart';
import 'package:haengunse/screens/home/session_card.dart';
import 'package:haengunse/screens/home/session_day.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SessionLucky(userName: userName, screenHeight: screenHeight),
          SessionCard(screenHeight: screenHeight), //여기 수정할 것
          SessionDay(screenHeight: screenHeight), //여기 수정할 것
        ],
      ),
    );
  }
}
