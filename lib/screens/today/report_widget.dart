import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

class ReportWidget extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  const ReportWidget({super.key, this.responseData});

  @override
  Widget build(BuildContext context) {
    // 점수 데이터 파싱
    final double wealthScore =
        (responseData?['wealthFortune']?['score'] ?? 0).toDouble();
    final double loveScore =
        (responseData?['loveFortune']?['score'] ?? 0).toDouble();
    final double healthScore =
        (responseData?['healthFortune']?['score'] ?? 0).toDouble();
    final double studyScore =
        (responseData?['studyFortune']?['score'] ?? 0).toDouble();
    final double careerScore =
        (responseData?['careerFortune']?['score'] ?? 0).toDouble();

    final List<double> scores = [
      wealthScore,
      loveScore,
      healthScore,
      studyScore,
      careerScore,
    ];

    final List<String> labels = ['재물운', '애정운', '건강운', '학업운', '업무운'];

    return Center(
      child: SizedBox(
        width: 200.w,
        height: 200.w,
        child: CustomPaint(
          painter: RadarChartPainter(scores: scores, labels: labels),
        ),
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<double> scores; // 5개 점수
  final List<String> labels;

  RadarChartPainter({required this.scores, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final int sides = 5;
    final double radius = size.width / 2 * 0.8;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;
    final Paint filledPaint = Paint()
      ..color = Colors.lightBlueAccent.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final Paint outlinePaint = Paint()
      ..color = const Color.fromARGB(255, 154, 240, 255)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint levelPaint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final Paint levelPaint2 = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // 단계별 배경
    for (int level = 5; level >= 1; level--) {
      final double r = radius * (level / 5);
      final path = Path();
      for (int i = 0; i < sides; i++) {
        final angle = (pi * 2 / sides) * i - pi / 2;
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();

      canvas.drawPath(path, (level % 2 == 0) ? levelPaint2 : levelPaint1);
      canvas.drawPath(path, gridPaint);
    }

    // 만점 점 그리기
    final Paint maxPointOutlinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.5) // 테두리 색상
      ..strokeWidth = 1.5.w // 선 굵기
      ..style = PaintingStyle.stroke; // ★ 테두리만!

    for (int i = 0; i < sides; i++) {
      final angle = (pi * 2 / sides) * i - pi / 2;
      final double x = center.dx + radius * cos(angle); // 5점 만점 위치
      final double y = center.dy + radius * sin(angle);

      canvas.drawCircle(Offset(x, y), 2.w, maxPointOutlinePaint); // 반지름 4.w
    }

    // 점수 영역
    final Path scorePath = Path();
    for (int i = 0; i < sides; i++) {
      final angle = (pi * 2 / sides) * i - pi / 2;
      final double percent = (scores[i] / 5.0).clamp(0.0, 1.0);
      final double x = center.dx + radius * percent * cos(angle);
      final double y = center.dy + radius * percent * sin(angle);
      if (i == 0) {
        scorePath.moveTo(x, y);
      } else {
        scorePath.lineTo(x, y);
      }
    }

    scorePath.close();
    canvas.drawPath(scorePath, filledPaint);
    canvas.drawPath(scorePath, outlinePaint);

    // 레이블 추가
    final TextStyle labelStyle = TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    );

    for (int i = 0; i < sides; i++) {
      final angle = (pi * 2 / sides) * i - pi / 2;

      // 기본 거리
      double distance = radius + 20;

      // "업무운(4번 인덱스)", "애정운(1번 인덱스)"만 거리를 추가
      if (i == 1 || i == 4) {
        distance += 8; // 약간만 바깥으로 (8 정도)
      }

      final double labelX = center.dx + distance * cos(angle);
      final double labelY = center.dy + distance * sin(angle);

      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: labels[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: 100.w);

      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) => false;
}
