import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetryButtons extends StatelessWidget {
  final int index;
  final void Function(int) onRetry;
  final void Function(int) onCancel;

  const RetryButtons({
    super.key,
    required this.index,
    required this.onRetry,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () => onCancel(index),
            icon: Icon(Icons.close, color: Colors.red, size: 16.sp),
            label: Text(
              "취소",
              style: TextStyle(
                color: Colors.red,
                fontSize: 13.sp,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => onRetry(index),
            icon: Icon(Icons.refresh, color: Colors.blue, size: 16.sp),
            label: Text(
              "다시 시도",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
