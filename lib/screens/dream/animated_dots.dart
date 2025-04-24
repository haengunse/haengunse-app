import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  int _dotCount = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (mounted) {
        setState(() {
          _dotCount = (_dotCount % 3) + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '해석 중 ${'•' * _dotCount}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
    );
  }
}
