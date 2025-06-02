import 'package:flutter/material.dart';

class SajuDetailPage extends StatelessWidget {
  const SajuDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사주 해석 도움말')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 음양 설명
                Text('❓ 음/양(陰陽)의 의미',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  '우리가 사는 세상은 모든 것이 하나의 방향으로만 흐르지 않습니다. '
                  '밝음이 있으면 어둠이 있고, 움직임이, 있으면 멈춤도 있습니다. '
                  '이처럼 모든 사물과 기운에는 ‘양(陽)’과 ‘음(陰)’이라는 두 가지 성질이 존재합니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 8),
                Text(
                    '☀️ 양(陽)은 밖으로 뻗고 확장하는 기운입니다. 태양처럼 강하고, 활발하며, 빠르게 움직이는 성질을 가집니다.\n** 행운색에서는 밝은 색이에요!',
                    style: TextStyle(fontSize: 14, height: 1.6)),
                SizedBox(height: 4),
                Text(
                    '🌙 음(陰)은 안으로 모이고 감싸는 기운입니다. 달처럼 조용하고, 섬세하며, 유연한 에너지를 가집니다.\n** 행운색에서는 어두운 색이에요!',
                    style: TextStyle(fontSize: 14, height: 1.6)),
                SizedBox(height: 12),
                Text(
                  '사주에서는 이 음과 양이 얼마나 균형을 이루고 있는지를 살펴봅니다. '
                  '한쪽으로 치우칠수록 성격과 관계 흐름에도 영향을 주며, '
                  '서로 조화를 이루고 있을 때 자연스럽게 흘러가게 됩니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 24),

                // 오행 설명
                Text('❓ 오행(五行)의 의미',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  '오행은 세상의 기운을 다섯 가지로 나눈 이론입니다. '
                  '‘나무(木) · 불(火) · 흙(土) · 금속(金) · 물(水)’로 구분하며, '
                  '사람의 성격, 건강, 직관, 진로 등 다양한 면에 영향을 줍니다. '
                  '오행에는 각각의 성격과 작용 방식이 있으며, 서로를 도와주기도 하고(상생), 억제하기도 하며(상극), '
                  '이러한 관계 속에서 나의 성향과 균형을 찾아가는 것이 사주 해석의 핵심입니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 12),

                Text('🌳 목(木)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '나무처럼 자라고 뻗는 기운입니다. 성장, 시작, 창의성, 유연함을 상징합니다. '
                  '목이 강하면 리더십과 새로운 아이디어가 넘쳐납니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 12),

                Text('🔥 화(火)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '불처럼 타오르는 에너지입니다. 열정, 표현력, 추진력과 연결됩니다. '
                  '화가 강하면 감정 표현이 활발하고 적극적인 성향을 띱니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 12),

                Text('🪵 토(土)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '흙처럼 중심을 잡아주는 기운입니다. 안정감, 신뢰, 책임감과 관련됩니다. '
                  '토가 강하면 묵묵히 중심을 지키며 현실적인 성향이 강합니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 12),

                Text('⚙️ 금(金)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '금속처럼 단단하고 날카로운 기운입니다. 판단력, 이성, 결단력과 연결됩니다. '
                  '금이 강한 사람은 논리적이고 깔끔한 성격을 가집니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 12),

                Text('💧 수(水)',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '물처럼 부드럽고 흐르는 기운입니다. 감성, 지혜, 직관, 소통 능력과 관련됩니다. '
                  '수가 강하면 감성이 풍부하고 공감 능력이 뛰어난 경우가 많습니다.',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
