import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/onboarding/input_loading_page.dart';

class InputController {
  static Future<void> saveAndNavigateHome({
    required BuildContext context,
    required String name,
    required DateTime? selectedDate,
    required String calendarType,
    required String gender,
    required String? selectedBirthTime,
    required bool agreedToTerms,
  }) async {
    if (name.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("입력이 완료되지 않았어요. 모든 항목을 입력해주세요."),
          backgroundColor: Colors.grey[600],
        ),
      );
      return;
    }

    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("서비스 이용을 위해 약관 동의가 필요해요."),
          backgroundColor: Colors.grey[600],
        ),
      );
      return;
    }

    final formattedBirthDate =
        "${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    final isSolar = calendarType == "양력";
    final birthTimeLabel =
        selectedBirthTime == null || selectedBirthTime == "모름"
            ? "모름"
            : selectedBirthTime;

    final payload = {
      "birthDate": formattedBirthDate,
      "solar": isSolar,
      "birthTime": birthTimeLabel,
      "gender": gender,
      "name": name,
    };

    // isFirstRun = false 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
    await prefs.setString('birthDate', formattedBirthDate);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => InputLoadingPage(payload: payload),
      ),
    );
  }
}
