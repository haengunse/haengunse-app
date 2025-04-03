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
    final data = await fetch();
    onSuccess(data);
  } on DioException catch (e) {
    _handleDioException(context, e, retry);
  } catch (e) {
    _handleUnknownException(context, retry);
  }
}

/// Dio 예외 처리 전용
void _handleDioException(
    BuildContext context, DioException e, VoidCallback retry) {
  final error = _mapErrorFromDio(e);

  _goToError(
    context,
    title: error.title,
    message: error.message,
    errorType: error.type,
    retry: retry,
  );
}

/// 기타 예외 처리
void _handleUnknownException(BuildContext context, VoidCallback retry) {
  _goToError(
    context,
    title: "문제가 발생했어요",
    message: "잠시 후 다시 시도해주세요.",
    errorType: ErrorType.unknown,
    retry: retry,
  );
}

/// 에러 페이지 이동
void _goToError(
  BuildContext context, {
  required String title,
  required String message,
  required ErrorType errorType,
  required VoidCallback retry,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200), // 전환 속도
      pageBuilder: (_, __, ___) => ErrorPage(
        title: title,
        message: message,
        errorType: errorType,
        onRetry: () {
          Navigator.of(context).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            retry();
          });
        },
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}

/// Dio 예외를 ErrorData로 변환
ErrorData _mapErrorFromDio(DioException e) {
  if (e.response?.statusCode == 400) {
    return const ErrorData(
      title: "잘못된 요청",
      message: "요청 형식이 올바르지 않아요.",
      type: ErrorType.badRequest,
    );
  } else if (e.response?.statusCode == 500) {
    return const ErrorData(
      title: "서버 오류",
      message: "서버에서 문제가 발생했어요.\n잠시 후 다시 시도해주세요.",
      type: ErrorType.serverError,
    );
  } else if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.unknown) {
    return const ErrorData(
      title: "연결 실패",
      message: "인터넷 또는 서버 연결이 불안정해요.",
      type: ErrorType.connectionError,
    );
  }

  return const ErrorData(
    title: "알 수 없는 오류",
    message: "예기치 못한 문제가 발생했어요.",
    type: ErrorType.unknown,
  );
}

/// 에러 데이터 모델
class ErrorData {
  final String title;
  final String message;
  final ErrorType type;

  const ErrorData({
    required this.title,
    required this.message,
    required this.type,
  });
}
