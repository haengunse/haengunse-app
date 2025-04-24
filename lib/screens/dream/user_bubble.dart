import 'package:flutter/material.dart';
import 'package:haengunse/service/dream/dream_message.dart';
import 'animated_dots.dart';

class UserBubble extends StatelessWidget {
  final DreamMessage message;
  final bool isFirst;
  final double maxWidth;

  const UserBubble({
    super.key,
    required this.message,
    required this.isFirst,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      margin: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: message.isLoading
          ? const AnimatedDots()
          : Text(message.text, style: const TextStyle(fontSize: 13)),
    );
  }
}
