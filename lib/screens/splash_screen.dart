import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/service/today/today_interactor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _prepareRequest();
  }

  Future<void> _prepareRequest() async {
    final prefs = await SharedPreferences.getInstance();

    final manseInfo = prefs.getString('manseInfo');
    final gender = prefs.getString('gender');

    final jsonData = {
      'manseInfo': manseInfo,
      'gender': gender,
    };

    TodayInteractor(
      context: context,
      userData: jsonData,
    ).handleTodayRequest();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
