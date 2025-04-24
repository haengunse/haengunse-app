import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/dream/dream_chat_box.dart';

class DreamScreen extends StatelessWidget {
  const DreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: const DreamChatBox(),
    );
  }
}
