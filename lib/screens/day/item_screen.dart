import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 500.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEED),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          // 닫기 버튼
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 24, color: Colors.black),
            ),
          ),
          // 메인 콘텐츠
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Image.asset(
                  'assets/images/item_card.png', // 🎁 아이템 카드 이미지
                  width: 150.w,
                  height: 150.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  "행운세가 전하는",
                  style: TextStyle(
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w200,
                    color: const Color.fromARGB(255, 96, 95, 95),
                  ),
                ),
                Text(
                  "오늘의 행운포인트",
                  style: TextStyle(
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 96, 95, 95),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "색상: ${item['color']}\n"
                  "장소: ${item['place']}\n"
                  "숫자: ${item['number']}\n"
                  "사물: ${item['object']}",
                  style: TextStyle(
                    fontFamily: 'HakgyoansimDunggeunmiso',
                    fontSize: 22.sp,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
