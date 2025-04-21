import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';
import 'dart:convert';

class DreamResponse {
  final String? reply;
  final bool isNetworkError;
  final bool isServerError;

  DreamResponse(
      {this.reply, this.isNetworkError = false, this.isServerError = false});
}

class DreamService {
  static Future<DreamResponse> sendDream(List<String> messages) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        Config.dreamApiUrl,
        data: messages,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return DreamResponse(reply: response.data['interpretation']);
      } else {
        // 200 외 나머지는 서버 오류로 처리
        return DreamResponse(isServerError: true);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        // 네트워크 오류
        return DreamResponse(isNetworkError: true);
      }
      // 기타 Dio 오류는 서버 오류로 처리
      return DreamResponse(isServerError: true);
    } catch (_) {
      return DreamResponse(isNetworkError: true);
    }
  }
}
