import 'package:flutter/material.dart';

class RetryButtons extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onCancel;

  const RetryButtons({
    super.key,
    required this.onRetry,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text("취소", style: TextStyle(color: Colors.red)),
          ),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: Colors.blue),
            label: const Text("다시 시도", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
