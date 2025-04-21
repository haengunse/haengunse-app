import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';
import 'dart:convert';

class DreamResult {
  final String? reply;
  final bool isNetworkError;

  DreamResult({this.reply, this.isNetworkError = false});
}

class DreamService {
  static Future<DreamResult> sendDream(List<String> messages) async {
    try {
      final dio = Dio();

      final response = await dio.post(
        Config.dreamApiUrl,
        data: messages,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return DreamResult(reply: response.data['interpretation'] as String?);
      } else {
        return DreamResult(); // 일반 서버 오류
      }
    } catch (e) {
      return DreamResult(isNetworkError: true); // 네트워크 오류
    }
  }
}
