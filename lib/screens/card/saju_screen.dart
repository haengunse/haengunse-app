import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/card/saju_detail_page.dart';
import 'package:haengunse/screens/card/user_saju_section.dart';

class SajuScreen extends StatelessWidget {
  final String manseInfo;
  final Map<String, String> sajuResult;
  final String userName;

  const SajuScreen({
    super.key,
    required this.manseInfo,
    required this.sajuResult,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "사주 해석",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 23,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SajuDetailPage()),
              );
            },
            backgroundColor:
                const Color.fromARGB(255, 114, 212, 140).withOpacity(0.85),
            child: Icon(Icons.question_mark, size: 28.sp, color: Colors.white),
            shape: const CircleBorder(),
          ),
          body: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.w,
                bottom: 0,
              ),
              child: ListView(
                children: [
                  UserSajuSection(
                    title: "$userName님의 사주",
                    content: "$manseInfo",
                  ),
                  _buildSection("💭 전체 해석", sajuResult['summary'] ?? ''),
                  _buildSection("💬 내 성격은", sajuResult['personality'] ?? ''),
                  _buildSection("🌿 오행 분석", sajuResult['fiveElements'] ?? ''),
                  _buildSection("⚖️ 십성 분석", sajuResult['tenGods'] ?? ''),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJusSelector() {
    final jus = ['시주', '일주', '월주', '년주'];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: jus
            .map(
              (label) => Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4.w, 4.h),
            blurRadius: 2.r,
            spreadRadius: 0.5.r,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(-4.w, 4.h),
            blurRadius: 2.r,
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
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
