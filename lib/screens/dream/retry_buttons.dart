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

  void _showBottomActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(217, 214, 214, 214),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SizedBox(height: 16.h),
              // Text(
              //   "문제가 발생했어요",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              // ),
              // SizedBox(height: 16.h),
              // Divider(height: 1, color: Colors.grey[300]),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onRetry(index);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: Colors.blue, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "다시 시도",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onCancel(index);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: Colors.red, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "취소",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.w, bottom: 11.h), // 전체 여백
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h), // 내부 패딩
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _showBottomActionSheet(context),
            child:
                Icon(Icons.close, size: 14.sp, color: Colors.black54), // 아이콘 크기
          ),
          SizedBox(width: 8.w), // 아이콘 간격
          GestureDetector(
            onTap: () => _showBottomActionSheet(context),
            child: Icon(Icons.refresh, size: 14.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
