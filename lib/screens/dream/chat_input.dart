import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DreamChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const DreamChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "꿈 이야기를 들려주세요",
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              ),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: Icon(Icons.send, color: Colors.black, size: 20.sp),
            splashRadius: 20.r,
          ),
        ],
      ),
    );
  }
}

class LimitMessageBox extends StatelessWidget {
  const LimitMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        "꿈 해몽은 하루에 한 번만 가능해요!\n궁금하다면 내일 다시 찾아와주세요.",
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
          height: 1.5,
          fontFamily: 'Pretendard',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
