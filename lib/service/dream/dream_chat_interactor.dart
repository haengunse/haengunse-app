import 'package:haengunse/service/dream/dream_service.dart';

/// 서버 응답을 가공한 결과 모델
class DreamChatResult {
  final String? reply; // 서버로부터의 정상 응답
  final bool isNetworkError; // 네트워크 오류 여부
  final bool isGeneralError; // 기타 오류 여부

  DreamChatResult({
    this.reply,
    this.isNetworkError = false,
    this.isGeneralError = false,
  });
}

/// 꿈 해몽 대화 흐름 제어 로직
class DreamChatInteractor {
  /// 서버에 dream 기록을 보내고, 응답을 해석하여 결과 객체로 리턴
  static Future<DreamChatResult> processChat(List<String> history) async {
    try {
      final result = await DreamService.sendDream(history);

      if (result.reply != null) {
        return DreamChatResult(reply: result.reply);
      } else if (result.isNetworkError) {
        return DreamChatResult(isNetworkError: true);
      } else {
        return DreamChatResult(isGeneralError: true);
      }
    } catch (_) {
      // 예외 상황 처리 (예: null 응답 등)
      return DreamChatResult(isGeneralError: true);
    }
  }
}
