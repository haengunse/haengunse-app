import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSajuSection extends StatelessWidget {
  final String title;
  final String content;

  const UserSajuSection({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final jus = ['시주', '일주', '월주', '년주'];

    final manseList = content.split(' ');
    final topIndices = [6, 4, 2, 0];
    final bottomIndices = [7, 5, 3, 1];

    String imagePath(String label) {
      if (label == '모름') {
        return 'assets/images/saju/unknown.png';
      }
      return 'assets/images/saju/${label.replaceAll('/', ':')}.png';
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4.w, 4.h),
            blurRadius: 1.r,
            spreadRadius: 0.5.r,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(-4.w, 4.h),
            blurRadius: 1.r,
            spreadRadius: 0.5.r,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),

          // 회색 바 + 텍스트 라벨
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: jus.map((label) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          SizedBox(height: 5.h),

          // 사주 이미지 2행
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Image.asset(
                        imagePath(manseList[topIndices[index]]),
                        fit: BoxFit.contain,
                        height: 65.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Image.asset(
                        imagePath(manseList[bottomIndices[index]]),
                        fit: BoxFit.contain,
                        height: 65.h,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
