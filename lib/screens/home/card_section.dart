import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/card/card_api.dart';
import 'package:haengunse/service/card/card_interactor.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.w, 20.h, 10.w, 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "다양한 운세를 알아볼까요?",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 132, 131, 131),
              fontFamily: 'Pretendard',
            ),
          ),
          Text(
            "운세 카드",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Pretendard',
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 150.h,
            child: FutureBuilder<List<FortuneCardData>>(
              future: CardService.fetchFortuneCards(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) {
                      final card = snapshot.data![index];
                      return GestureDetector(
                        onTap: () => CardInteractor.handleTap(
                          context: context,
                          card: card,
                        ),
                        child: _buildFortuneCard(
                          imagePath: card.imagePath,
                          smallTitle: card.smallTitle,
                          bigTitle: card.bigTitle,
                        ),
                      );
                    },
                  ),
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
      width: 130.w,
      height: 150.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5.r,
            spreadRadius: 1,
            offset: const Offset(0, -1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1.r,
            spreadRadius: 1,
            offset: const Offset(0, 1),
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
          SizedBox(height: 1.h),
          Text(
            smallTitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontFamily: 'Pretendard',
            ),
          ),
          Text(
            bigTitle,
            style: TextStyle(
              fontSize: 18.sp,
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
