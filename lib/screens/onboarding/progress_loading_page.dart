import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/manse/manse_interactor.dart';

class ProgressLoadingPage extends StatefulWidget {
  final Map<String, dynamic> payload;

  const ProgressLoadingPage({super.key, required this.payload});

  @override
  State<ProgressLoadingPage> createState() => _ProgressLoadingPageState();
}

class _ProgressLoadingPageState extends State<ProgressLoadingPage> {
  @override
  void initState() {
    super.initState();
    _startRequest();
  }

  void _startRequest() {
    final interactor = ManseInteractor(
      context: context,
      payload: widget.payload,
    );
    interactor.handleManseRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 수직 가운데 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 수평 가운데 정렬
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: const CircularProgressIndicator(
                    color: Color(0xFF82c784),
                    strokeWidth: 6.5,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  '내 정보 입력 완료',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  '작성하신 정보를 바탕으로\n운세를 계산하고 있어요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
