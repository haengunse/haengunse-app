import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final double screenHeight;

  const SessionCard({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3.4,
      width: double.infinity,
      color: const Color.fromARGB(231, 243, 243, 243),
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "다양한 운세를 알아볼까요?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 132, 131, 131),
              fontFamily: 'Pretendard',
            ),
          ),
          const Text(
            "운세 카드",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 145,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFortuneCard(
                  imagePath: 'assets/images/fortune_star.png',
                  smallTitle: '별이 건네는 이야기',
                  bigTitle: '별자리 운세',
                ),
                const SizedBox(width: 10),
                _buildFortuneCard(
                  imagePath: 'assets/images/fortune_zodiac.png',
                  smallTitle: '열두 띠의 하루',
                  bigTitle: '띠 운세',
                ),
                const SizedBox(width: 10),
                _buildFortuneCard(
                  imagePath: 'assets/images/fortune_dream.png',
                  smallTitle: '꿈이 알려주는 마음의 신호',
                  bigTitle: '꿈 해몽',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFortuneCard({
    required String imagePath,
    required String smallTitle,
    required String bigTitle,
  }) {
    return Container(
      width: 130,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, -1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            smallTitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontFamily: 'Pretendard',
            ),
          ),
          Text(
            bigTitle,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Pretendard',
            ),
          ),
        ],
      ),
    );
  }
}
