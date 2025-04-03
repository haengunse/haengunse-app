import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DayService {
  static final Dio _dio = Dio();

  /// 랜덤 질문 / 쿠키 메시지 요청
  static Future<String> fetchAnswer(String url) async {
    try {
      final response = await _dio.get(url);
      debugPrint('📩 응답 상태 코드: ${response.statusCode}');
      debugPrint('📦 응답 데이터: ${response.data}');
      debugPrint('🔎 응답 타입: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['answer'] is String) {
          return data['answer'];
        } else {
          throw Exception('응답 포맷 오류: answer 필드가 없습니다.');
        }
      } else {
        throw Exception('응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 행운 아이템 요청
  static Future<Map<String, dynamic>> fetchItem(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception('응답 포맷 오류: Map 형식이 아닙니다.');
        }
      } else {
        throw Exception('응답 오류: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
