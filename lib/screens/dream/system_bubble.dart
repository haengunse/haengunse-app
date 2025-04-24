import 'package:flutter/material.dart';
import 'package:haengunse/screens/dream/animated_dots.dart';
import 'package:haengunse/service/dream/dream_message.dart';

class SystemBubble extends StatelessWidget {
  final DreamMessage message;
  final bool isFirst;

  const SystemBubble({
    super.key,
    required this.message,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.7;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                'assets/images/moon_profile.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            margin: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
            ),
            child: message.isLoading
                ? const AnimatedDots()
                : Text(
                    message.text,
                    style: const TextStyle(fontSize: 13),
                  ),
          ),
        ),
      ],
    );
  }
}
