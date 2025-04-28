import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreWidget extends StatelessWidget {
  final int totalScore;

  const ScoreWidget({super.key, required this.totalScore});

  String _getLabel(int score) {
    if (score <= 50) return '주의';
    if (score <= 70) return '보통';
    return '좋음';
  }

  Color _getColor(int score) {
    return const Color.fromARGB(255, 255, 170, 51); // 주황
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabel(totalScore);

    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(120.w, 120.w),
            painter: _DonutPainter(
              progress: totalScore / 100,
              backgroundColor: const Color(0xFFFCEFD9), // 연베이지
              progressColor: _getColor(totalScore),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                "$totalScore점",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 24.sp,
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

class _DonutPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  _DonutPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.w;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1. 회색 그림자 레이어
    final shadowPaint = Paint()
      ..color = const Color(0xFFE0E0E0) // 연회색
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      0,
      2 * 3.1415926,
      false,
      shadowPaint,
    );

    // 2. 배경 (연베이지)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      0,
      2 * 3.1415926,
      false,
      backgroundPaint,
    );

    // 3. 진행도 (주황색)
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = -90 * 3.1415926 / 180;
    final sweepAngle = 2 * 3.1415926 * progress;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
