import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FortuneTextBox extends StatelessWidget {
  final String? title;
  final String description;

  const FortuneTextBox({
    super.key,
    this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(133, 232, 255, 244),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2.r,
            spreadRadius: 1.r,
            offset: const Offset(0, -1), // 위쪽 그림자
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 1), // 아래쪽 그림자
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.1, // 제목 줄간격
              ),
            ),
            SizedBox(height: 4.h), // 제목과 본문 간격
          ],
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              height: 1.25, // 본문 줄간격
            ),
          ),
        ],
      ),
    );
  }
}
