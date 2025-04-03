import 'package:flutter/material.dart';

enum ErrorType { badRequest, serverError, connectionError, unknown }

class ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final ErrorType errorType;

  const ErrorPage({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.errorType = ErrorType.unknown,
  });

  IconData _getIcon() {
    switch (errorType) {
      case ErrorType.badRequest:
        return Icons.warning_amber_rounded;
      case ErrorType.serverError:
        return Icons.cloud_off;
      case ErrorType.connectionError:
        return Icons.wifi_off;
      case ErrorType.unknown:
      default:
        return Icons.error_outline;
    }
  }

  Color _getIconColor() {
    switch (errorType) {
      case ErrorType.badRequest:
        return Colors.orange;
      case ErrorType.serverError:
        return Colors.grey;
      case ErrorType.connectionError:
        return Colors.blueGrey;
      case ErrorType.unknown:
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getIcon(), size: 80, color: _getIconColor()),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text("다시 시도"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
