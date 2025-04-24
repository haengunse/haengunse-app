import 'package:flutter/material.dart';
import 'package:haengunse/service/dream/dream_message.dart';

class UserBubble extends StatelessWidget {
  final DreamMessage message;
  final bool isFirst;

  const UserBubble({
    super.key,
    required this.message,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.6;

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      margin: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message.text,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
