import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/input_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/today_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    // 테스트용 강제 초기화 (배포 시 제거)
    await prefs.clear();

    return prefs.getBool('isFirstRun') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "오늘의 운세",
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        '/today': (context) => const TodayScreen(),
        '/splash': (context) => const SplashScreen(),
      },
      home: FutureBuilder<bool>(
        future: checkFirstRun(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data! ? const InputScreen() : const HomeScreen();
        },
      ),
    );
  }
}
