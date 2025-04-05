import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:haengunse/screens/error_page.dart';
import 'package:haengunse/utils/error_type.dart';

Future<void> handleRequest<T>({
  required BuildContext context,
  required Future<T> Function() fetch,
  required void Function(T data) onSuccess,
  required VoidCallback retry,
}) async {
  try {
    final data = await fetch();
    if (context.mounted) {
      onSuccess(data);
    }
  } on DioException catch (e) {
    if (context.mounted) {
      _handleDioException(context, e, retry);
    }
  } catch (e) {
    if (context.mounted) {
      _handleUnknownException(context, retry);
    }
  }
}

void _handleDioException(
  BuildContext context,
  DioException e,
  VoidCallback retry,
) {
  final error = _mapErrorFromDio(e);
  _goToError(
    context,
    title: error.title,
    message: error.message,
    errorType: error.type,
    retry: retry,
  );
}

void _handleUnknownException(BuildContext context, VoidCallback retry) {
  _goToError(
    context,
    title: "문제가 발생했어요",
    message: "잠시 후 다시 시도해주세요.",
    errorType: ErrorType.unknown,
    retry: retry,
  );
}

void _goToError(
  BuildContext context, {
  required String title,
  required String message,
  required ErrorType errorType,
  required VoidCallback retry,
}) {
  if (!context.mounted) return;

  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => ErrorPage(
        title: title,
        message: message,
        errorType: errorType,
        onRetry: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            retry();
          });
        },
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

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
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
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
