import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:haengunse/screens/error_page.dart';

Future<void> handleRequest<T>({
  required BuildContext context,
  required Future<T> Function() fetch,
  required void Function(T data) onSuccess,
}) async {
  try {
    final data = await fetch();
    onSuccess(data);
  } on DioException catch (e) {
    debugPrint("❗ DioException 발생: $e");

    if (e.response?.statusCode == 400) {
      _goToError(
        context,
        "잘못된 요청",
        "요청 형식이 올바르지 않아요.",
        fetch,
        onSuccess,
        type: ErrorType.badRequest,
      );
    } else if (e.response?.statusCode == 500) {
      _goToError(
        context,
        "서버 오류",
        "서버에서 문제가 발생했어요.\n잠시 후 다시 시도해주세요.",
        fetch,
        onSuccess,
        type: ErrorType.serverError,
      );
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.unknown) {
      _goToError(
        context,
        "연결 실패",
        "인터넷 또는 서버 연결이 불안정해요.",
        fetch,
        onSuccess,
        type: ErrorType.connectionError,
      );
    } else {
      _goToError(
        context,
        "알 수 없는 오류",
        "예기치 못한 문제가 발생했어요.",
        fetch,
        onSuccess,
        type: ErrorType.unknown,
      );
    }
  } catch (e) {
    debugPrint("❗ 기타 예외 발생: $e");

    _goToError(
      context,
      "문제가 발생했어요",
      "잠시 후 다시 시도해주세요.",
      fetch,
      onSuccess,
      type: ErrorType.unknown,
    );
  }
}

void _goToError<T>(
  BuildContext context,
  String title,
  String message,
  Future<T> Function() fetch,
  void Function(T data) onSuccess, {
  ErrorType type = ErrorType.unknown,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ErrorPage(
        title: title,
        message: message,
        errorType: type,
        onRetry: () {
          Navigator.pop(context); // 에러 페이지 닫기
          handleRequest(
            context: context,
            fetch: fetch,
            onSuccess: onSuccess,
          );
        },
      ),
    ),
  );
}
