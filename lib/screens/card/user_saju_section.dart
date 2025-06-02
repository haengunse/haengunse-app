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

    final manseList = content.split(' ');
    final topIndices = [6, 4, 2, 0]; // 7 5 3 1
    final bottomIndices = [7, 5, 3, 1]; // 8 6 4 2

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
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // 긴 회색 바 + 텍스트 Row를 겹쳐서 오버레이
          Stack(
            alignment: Alignment.center,
            children: [
              // 긴 회색 바
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              // 텍스트 라벨 Row
              Row(
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

          const SizedBox(height: 8),

          // 이미지 2줄, 4개 column으로 구성
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.asset(
                        imagePath(manseList[topIndices[index]]),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
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
