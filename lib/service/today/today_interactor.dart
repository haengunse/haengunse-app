import 'package:flutter/material.dart';
import 'package:haengunse/service/today/today_repository.dart';
import 'package:haengunse/utils/request_helper.dart';
import 'package:haengunse/screens/today/today_screen.dart';

class TodayInteractor {
  final BuildContext context;
  final Map<String, dynamic> userData;

  TodayInteractor({
    required this.context,
    required this.userData,
  });

  /// 오늘의 운세 요청 및 스크린 전환 핸들링
  Future<void> handleTodayRequest() async {
    await handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () async {
        final response = await TodayRepository.fetchToday(userData);
        return response;
      },
      onSuccess: (responseData) {
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TodayScreen(
              requestData: userData,
              responseData: responseData,
            ),
          ),
        );
      },
      retry: () {
        final interactor = TodayInteractor(
          context: context,
          userData: userData,
        );
        interactor.handleTodayRequest();
      },
    );
  }
}
