import 'package:flutter/material.dart';
import 'package:haengunse/service/day/day_interactor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionDay extends StatelessWidget {
  const SectionDay({super.key});

  Future<void> _showDialog(BuildContext context, Widget child) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.all(30.w),
        child: child,
      ),
    );
  }

  Widget _buildPreviewCard(
      BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5E5E5E),
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16.sp, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "오늘, 나의 하루 미리보기",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Pretendard',
            ),
          ),
          SizedBox(height: 12.h),
          _buildPreviewCard(
            context,
            "오늘의 당신을 위한 랜덤 질문을 뽑아봤어요.",
            () => DayInteractor.handleRandomTap(
              context,
              (child) => _showDialog(context, child),
            ),
          ),
          _buildPreviewCard(
            context,
            "오늘 하루, 마음에 담아두면 좋을 한마디예요.",
            () => DayInteractor.handleCookieTap(
              context,
              (child) => _showDialog(context, child),
            ),
          ),
          _buildPreviewCard(
            context,
            "오늘 당신께 필요한 행운 아이템을 모아봤어요.",
            () => DayInteractor.handleItemTap(
              context,
              (child) => _showDialog(context, child),
            ),
          ),
        ],
      ),
    );
  }
}
