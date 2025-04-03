import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:haengunse/screens/error_page.dart';

Future<void> handleRequest<T>({
  required BuildContext context,
  required Future<T> Function() fetch,
  required void Function(T data) onSuccess,
  required VoidCallback retry,
}) async {
  try {
    debugPrint('📤 fetch 요청 시작');
    final data = await fetch();
    debugPrint('✅ fetch 성공: \$data');
    onSuccess(data);
  } on DioException catch (e) {
    debugPrint("❗ DioException 발생: \$e");

    _goToError(
      context,
      title: _getErrorTitle(e),
      message: _getErrorMessage(e),
      retry: () => handleRequest<T>(
          context: context, fetch: fetch, onSuccess: onSuccess, retry: retry),
      type: _getErrorType(e),
    );
  } catch (e, stack) {
    debugPrint("❗ 기타 예외 발생: \$e");
    debugPrint("📌 Stack: \$stack");

    _goToError(
      context,
      title: "문제가 발생했어요",
      message: "잠시 후 다시 시도해주세요.",
      retry: () => handleRequest<T>(
        context: context,
        fetch: fetch,
        onSuccess: onSuccess,
        retry: retry,
      ),
      type: ErrorType.unknown,
    );
  }
}

void _goToError(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback retry,
  ErrorType type = ErrorType.unknown,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext pageContext) => ErrorPage(
        title: title,
        message: message,
        errorType: type,
        onRetry: () {
          debugPrint('🔁 onRetry 실행됨!');
          Navigator.of(pageContext).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            retry();
          });
        },
      ),
    ),
  );
}

String _getErrorTitle(DioException e) {
  if (e.response?.statusCode == 400) return "잘못된 요청";
  if (e.response?.statusCode == 500) return "서버 오류";
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.unknown) return "연결 실패";
  return "알 수 없는 오류";
}

String _getErrorMessage(DioException e) {
  if (e.response?.statusCode == 400) return "요청 형식이 올바르지 않아요.";
  if (e.response?.statusCode == 500) return "서버에서 문제가 발생했어요.\n잠시 후 다시 시도해주세요.";
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.unknown) return "인터넷 또는 서버 연결이 불안정해요.";
  return "예기치 못한 문제가 발생했어요.";
}

ErrorType _getErrorType(DioException e) {
  if (e.response?.statusCode == 400) return ErrorType.badRequest;
  if (e.response?.statusCode == 500) return ErrorType.serverError;
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.unknown) return ErrorType.connectionError;
  return ErrorType.unknown;
}
