import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/utils/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    // 테스트용 강제 초기화 (배포 시 제거)
    // await prefs.clear();

    return prefs.getBool('isFirstRun') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder<bool>(
          future: checkFirstRun(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            
            final isFirstRun = snapshot.data ?? true;
            
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "행운세",
              theme: ThemeData(
                primarySwatch: Colors.green,
                scaffoldBackgroundColor: Colors.white,
                canvasColor: Colors.white,
                drawerTheme: const DrawerThemeData(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                ),
                colorScheme: ColorScheme.light(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  background: Colors.white,
                  surface: Colors.white,
                ),
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: isFirstRun ? '/' : '/todaysplash',
              locale: const Locale('ko'),
              supportedLocales: const [
                Locale('ko'),
                Locale('en'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}
