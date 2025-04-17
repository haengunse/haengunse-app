import 'package:flutter/material.dart';
import 'package:haengunse/service/card/card_api.dart';
import 'package:haengunse/service/card/card_interactor.dart';

class SectionCard extends StatelessWidget {
  final double screenHeight;

  const SectionCard({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 3.3,
      width: double.infinity,
      color: const Color.fromARGB(231, 243, 243, 243),
      padding: const EdgeInsets.fromLTRB(15, 20, 10, 15),
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
            height: 150,
            child: FutureBuilder<List<FortuneCardData>>(
              future: CardService.fetchFortuneCards(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final card = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => CardInteractor.handleTap(
                        context: context,
                        route: card.route,
                      ),
                      child: _buildFortuneCard(
                        imagePath: card.imagePath,
                        smallTitle: card.smallTitle,
                        bigTitle: card.bigTitle,
                      ),
                    );
                  },
                );
              },
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, -1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
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
