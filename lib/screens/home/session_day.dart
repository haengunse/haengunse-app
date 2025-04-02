import 'package:flutter/material.dart';

class SessionDay extends StatelessWidget {
  final double screenHeight;

  const SessionDay({super.key, required this.screenHeight});

  Widget _buildPreviewCard(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5E5E5E),
                fontFamily: 'Pretendard',
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2.63,
      width: double.infinity,
      color: const Color(0xFFF3F3F3),
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "오늘, 나의 하루 미리보기",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 15),
          _buildPreviewCard("오늘의 전반적인 흐름은 어떨까요?"),
          _buildPreviewCard("오늘의 작은 주의사항은 어떤 게 있을까요?"),
          _buildPreviewCard("오늘의 행운포인트"),
        ],
      ),
    );
  }
}
