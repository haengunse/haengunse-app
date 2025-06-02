import 'package:flutter/material.dart';

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

    // 사주 정보 파싱
    final manseList = content.split(' ');
    final topIndices = [6, 4, 2, 0]; // 7 5 3 1
    final bottomIndices = [7, 5, 3, 1]; // 8 6 4 2

    // 이미지 경로 생성 함수
    String imagePath(String label) {
      return 'assets/images/saju/${label.replaceAll('/', '_')}.png';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // 회색 바 + 텍스트 라벨 (Stack 이용)
          Stack(
            alignment: Alignment.center,
            children: [
              // 회색 배경 바
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(), // 수직 정렬 기준 제공
              ),
              // 텍스트 라벨 (가운데 정렬)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: jus.map((label) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // 이미지 영역 (4열 × 2행)
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Image.asset(
                        imagePath(manseList[topIndices[index]]),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Image.asset(
                        imagePath(manseList[bottomIndices[index]]),
                        fit: BoxFit.contain,
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
