import 'package:flutter/material.dart';

class DreamChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const DreamChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: "꿈 이야기를 들려주세요",
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: const Icon(Icons.send, color: Colors.black),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

class LimitMessageBox extends StatelessWidget {
  const LimitMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "꿈 해몽은 하루에 한 번만 가능해요!\n궁금하다면 내일 다시 찾아와주세요.",
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
          height: 1.5,
          fontFamily: 'Pretendard',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
