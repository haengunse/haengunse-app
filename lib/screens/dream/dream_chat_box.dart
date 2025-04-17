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
  int _chatCount = 0; // 채팅 횟수 제한용

  @override
  void initState() {
    super.initState();
    _messages.add(
      DreamMessage(
        text: "꿈은 마음이 보내는 반짝이는 메시지일지도 몰라요. 어떤 꿈이었는지 저에게 살짝 들려주신다면, 해석해드릴게요.",
        isUser: false,
      ),
    );
  }

  void _sendMessage(String input) async {
    if (input.trim().isEmpty || _chatCount >= 3) return;

    setState(() {
      _messages.add(DreamMessage(text: input, isUser: true));
      _chatCount++; // 채팅 횟수 증가
    });

    _controller.clear();
    _scrollToBottom();

    final history =
        _messages.where((m) => m.isUser).map((m) => m.text).toList();
    final reply = await DreamService.sendDream(history);

    if (reply != null) {
      setState(() {
        _messages.add(DreamMessage(text: reply, isUser: false));
      });
      _scrollToBottom();
    }
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
                padding: const EdgeInsets.all(16),
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
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? Colors.green[100]
                            : Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(10),
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
            if (_chatCount < 3) // 3회 이하일 때만 입력 허용
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: _sendMessage,
                        decoration: const InputDecoration(
                          hintText: "꿈 이야기를 들려주세요",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "꿈 해몽은 최대 3번까지 가능합니다.",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
