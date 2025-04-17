import 'package:flutter/material.dart';
import 'package:haengunse/service/dream/dream_service.dart';
import 'package:haengunse/service/dream/dream_message.dart';

class DreamChatBox extends StatefulWidget {
  const DreamChatBox({super.key});

  @override
  State<DreamChatBox> createState() => _DreamChatBoxState();
}

class _DreamChatBoxState extends State<DreamChatBox> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<DreamMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _addSystemMessage(
        "꿈은 마음이 보내는 반짝이는 메시지일지도 몰라요. 어떤 꿈이었는지 저에게 살짝 들려주신다면, 해석해드릴게요.");
  }

  void _addSystemMessage(String text) {
    setState(() {
      _messages.add(DreamMessage(text: text, isUser: false));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(DreamMessage(text: text, isUser: true));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _handleSendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    _addUserMessage(input);
    _controller.clear();

    final history =
        _messages.where((m) => m.isUser).map((m) => m.text).toList();

    final reply = await DreamService.sendDream(history);

    if (reply != null) {
      _addSystemMessage(reply);
    } else {
      _addSystemMessage("죄송해요. 지금은 해석을 도와드릴 수 없어요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/dream_background.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        color:
                            message.isUser ? Colors.green[200] : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white.withOpacity(0.8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _handleSendMessage(),
                      decoration: const InputDecoration.collapsed(
                          hintText: "꿈을 입력해 주세요..."),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _handleSendMessage,
                    color: Colors.green[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
