import 'package:flutter/material.dart';
import 'package:haengunse/screens/day/random_screen.dart';
import 'package:haengunse/screens/day/cookie_screen.dart';
import 'package:haengunse/screens/day/item_screen.dart';
import 'package:haengunse/service/day_service.dart';
import 'package:haengunse/config.dart';
import 'package:haengunse/utils/request_helper.dart';

class SectionDay extends StatelessWidget {
  final double screenHeight;

  const SectionDay({super.key, required this.screenHeight});

  Future<void> _showDialog(BuildContext context, Widget child) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.all(30),
        child: child,
      ),
    );
  }

  void _handleRandomTap(BuildContext context) {
    final url = Config.messageRandomUrl;

    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageRandomUrl),
      onSuccess: (answer) {
        _showDialog(context, RandomScreen(answer: answer));
      },
      retry: () => _handleRandomTap(context),
    );
  }

  void _handleCookieTap(BuildContext context) {
    handleRequest<String>(
      context: context,
      fetch: () => DayService.fetchAnswer(Config.messageCookieUrl),
      onSuccess: (answer) {
        _showDialog(context, CookieScreen(answer: answer));
      },
      retry: () => _handleCookieTap(context),
    );
  }

  void _handleItemTap(BuildContext context) {
    handleRequest<Map<String, dynamic>>(
      context: context,
      fetch: () => DayService.fetchItem(Config.messageItemUrl),
      onSuccess: (item) {
        _showDialog(context, ItemScreen(item: item));
      },
      retry: () => _handleItemTap(context),
    );
  }

  Widget _buildPreviewCard(
      BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2.8,
      width: double.infinity,
      color: const Color.fromARGB(231, 243, 243, 243),
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
          _buildPreviewCard(
            context,
            "오늘의 당신을 위한 랜덤 질문을 뽑아봤어요.",
            () => _handleRandomTap(context),
          ),
          _buildPreviewCard(
            context,
            "오늘 하루, 마음에 담아두면 좋을 한마디예요.",
            () => _handleCookieTap(context),
          ),
          _buildPreviewCard(
            context,
            "오늘 당신께 필요한 행운 아이템을 모아봤어요.",
            () => _handleItemTap(context),
          ),
        ],
      ),
    );
  }
}
