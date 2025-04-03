import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("행운 아이템 화면")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("색상: ${item['color']}"),
            Text("숫자: ${item['number']}"),
            Text("장소: ${item['place']}"),
            Text("사물: ${item['object']}"),
          ],
        ),
      ),
    );
  }
}
