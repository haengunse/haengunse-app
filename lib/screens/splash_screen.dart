import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/today_screen.dart';
import 'package:haengunse/service/today/today_repository.dart';
import 'package:haengunse/utils/request_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, dynamic>? requestData;

  @override
  void initState() {
    super.initState();
    _fetchTodayFortune();
  }

  Future<void> _fetchTodayFortune() async {
    final prefs = await SharedPreferences.getInstance();

    final birthDate = prefs.getString('birthDate');
    final solar = prefs.getString('solar');
    final birthTime = prefs.getString('birthTime');
    final gender = prefs.getString('gender');
    final name = prefs.getString('name');

    if ([birthDate, solar, birthTime, gender, name].contains(null) ||
        name!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("유저 정보가 누락되어 요청할 수 없습니다.")),
      );
      return;
    }

    final jsonData = {
      'birthDate': birthDate,
      'solar': solar,
      'birthTime': birthTime,
      'gender': gender,
      'name': name,
    };

    setState(() {
      requestData = jsonData;
    });

    await handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () => TodayRepository.fetchToday(jsonData),
      onSuccess: (responseData) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TodayScreen(
              requestData: jsonData,
              responseData: responseData,
            ),
          ),
        );
      },
      retry: _fetchTodayFortune,
    );
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
