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
    if (e.response?.statusCode == 400) {
      _goToError(context, "잘못된 요청", "요청 형식이 잘못되었어요.", fetch, onSuccess);
    } else if (e.response?.statusCode == 500) {
      _goToError(context, "서버 오류", "서버에서 문제가 발생했어요.", fetch, onSuccess);
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.unknown) {
      _goToError(context, "연결 실패", "인터넷 또는 서버 연결이 끊어졌어요.", fetch, onSuccess);
    } else {
      _goToError(context, "알 수 없는 오류", "예기치 못한 문제가 발생했어요.", fetch, onSuccess);
    }
  } catch (e) {
    _goToError(context, "예외 발생", e.toString(), fetch, onSuccess);
  }
}

void _goToError<T>(
  BuildContext context,
  String title,
  String message,
  Future<T> Function() fetch,
  void Function(T data) onSuccess,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ErrorPage(
        title: title,
        message: message,
        onRetry: () {
          Navigator.pop(context); // 에러 페이지 닫기
          handleRequest(
              context: context, fetch: fetch, onSuccess: onSuccess); // 재시도
        },
      ),
    ),
  );
}
