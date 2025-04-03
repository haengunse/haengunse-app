import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const ErrorPage({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: const Color(0xFFF3F3F3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 80, color: Colors.redAccent),
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("뒤로가기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
