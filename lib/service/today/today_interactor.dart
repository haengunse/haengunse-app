// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:haengunse/service/today/today_repository.dart';
// import 'package:haengunse/utils/request_helper.dart';
// import 'package:haengunse/screens/today_screen.dart';

// class TodayInteractor {
//   static Future<void> handleTodayRequest(
//     BuildContext context,
//     String userName, {
//     required VoidCallback onSplash,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();

//     final birthDate = prefs.getString('birthDate');
//     final solar = prefs.getString('solar');
//     final birthTime = prefs.getString('birthTime');
//     final gender = prefs.getString('gender');

//     if ([birthDate, solar, birthTime, gender, userName].contains(null) ||
//         userName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("유저 정보가 누락되어 요청할 수 없습니다.")),
//       );
//       return;
//     }

//     final jsonData = {
//       'birthDate': birthDate,
//       'solar': solar,
//       'birthTime': birthTime,
//       'gender': gender,
//       'name': userName,
//     };

//     // Splash UI 표시 트리거 (화면은 이미 splash 상태로 보여지고 있어야 함)
//     onSplash();

//     await handleRequest<Map<String, dynamic>>(
//       context: context,
//       fetch: () => TodayRepository.fetchToday(jsonData),
//       onSuccess: (responseData) {
//         if (context.mounted) {
//           Navigator.pushReplacement(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (_, __, ___) => TodayScreen(
//                 requestData: jsonData,
//                 responseData: {
//                   'totalScore': responseData['totalScore'],
//                   'generalFortune': responseData['generalFortune'],
//                   'wealthFortune': responseData['wealthFortune'],
//                   'loveFortune': responseData['loveFortune'],
//                   'healthFortune': responseData['healthFortune'],
//                   'studyFortune': responseData['studyFortune'],
//                   'careerFortune': responseData['careerFortune'],
//                   'dailyMessage': responseData['dailyMessage'],
//                 },
//               ),
//               transitionDuration: Duration.zero,
//               reverseTransitionDuration: Duration.zero,
//             ),
//           );
//         }
//       },
//       retry: () => handleTodayRequest(context, userName, onSplash: onSplash),
//     );
//   }
// }
