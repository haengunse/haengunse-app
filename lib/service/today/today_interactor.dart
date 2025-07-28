import 'package:flutter/material.dart';
import 'package:haengunse/service/today/today_repository.dart';
import 'package:haengunse/service/today/today_cache_storage.dart';
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
    // 캐시된 데이터 확인
    final cachedResponse = await TodayCacheStorage.loadResponse();
    if (cachedResponse != null) {
      if (!context.mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TodayScreen(
            requestData: userData,
            responseData: cachedResponse,
          ),
        ),
      );
      return;
    }

    // 캐시가 없거나 날짜가 다른 경우 서버 요청
    await handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () async {
        final response = await TodayRepository.fetchToday(userData);
        return response;
      },
      onSuccess: (responseData) async {
        // 응답 캐싱
        await TodayCacheStorage.saveResponse(responseData);
        
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
