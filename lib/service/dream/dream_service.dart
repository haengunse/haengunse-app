import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';

class DreamService {
  static Future<String?> sendDream(List<String> messages) async {
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
        return response.data['interpretation'] as String?;
      } else {
        print("❗ 응답 오류: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❗ 서버 오류: $e");
      return null;
    }
  }
}
