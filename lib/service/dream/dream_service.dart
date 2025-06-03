import 'package:dio/dio.dart';
import 'package:haengunse/config.dart';

class DreamResponse {
  final String? reply;
  final bool isNetworkError;
  final bool isServerError;

  DreamResponse({
    this.reply,
    this.isNetworkError = false,
    this.isServerError = false,
  });
}

class DreamService {
  static Future<DreamResponse> sendDream(List<String> messages) async {
    try {
      final dio = Dio();
      print('보내는 메시지: $messages');

      final response = await dio.post(
        Config.dreamApiUrl,
        data: messages,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print('응답 상태 코드: ${response.statusCode}');
      print('응답 데이터: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data.containsKey('interpretation') &&
            data['interpretation'] != null) {
          print('interpretation 필드 있음: ${data['interpretation']}');
          return DreamResponse(reply: data['interpretation']);
        } else {
          print('interpretation 필드 없음 또는 null');
          return DreamResponse(isServerError: true);
        }
      } else {
        print(
            '서버 오류: statusCode=${response.statusCode}, data=${response.data}');
        return DreamResponse(isServerError: true);
      }
    } on DioException catch (e) {
      print('Dio 예외 발생: ${e.type}, message=${e.message}');
      final statusCode = e.response?.statusCode;
      if (e.response != null) {
        print('예외 응답 상태: $statusCode');
        print('예외 응답 데이터: ${e.response?.data}');
      }

      // 서버 오류로 분류할 HTTP 상태 코드 목록
      const serverErrorCodes = [400, 422, 500, 502, 503];
      if (statusCode != null && serverErrorCodes.contains(statusCode)) {
        return DreamResponse(isServerError: true);
      }

      return DreamResponse(isNetworkError: true);
    } catch (e) {
      print('기타 예외 발생: $e');
      return DreamResponse(isNetworkError: true);
    }
  }
}
