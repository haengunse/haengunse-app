import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreWidget extends StatelessWidget {
  final int totalScore;

  const ScoreWidget({super.key, required this.totalScore});

  String _getLabel(int score) {
    if (score <= 50) return '주의';
    if (score <= 70) return '보통';
    return '최고';
  }

  Color _getColor(int score) {
    return Colors.orangeAccent;
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabel(totalScore);

    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 배경 원
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: CircularProgressIndicator(
              value: totalScore / 100,
              strokeWidth: 10.w,
              backgroundColor: const Color(0xFFFCEFD9), // 연한 베이지색
              valueColor: AlwaysStoppedAnimation<Color>(_getColor(totalScore)),
            ),
          ),

          // 텍스트 레이어
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "$totalScore점",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
