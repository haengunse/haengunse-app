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

        // 회차별 템플릿 응답
        if (_chatCount == 1) {
          _messages.add(DreamMessage(
            text:
                "꿈속에서 느꼈던 감정이나 더 자세한 상황을 알려주시면, 해석에 큰 도움이 돼요 :)\n추가로 궁금한 점이 있다면 지금이 첫 질문 기회예요!\n물론, 여기서 마무리하셔도 괜찮아요.",
            isUser: false,
          ));
        } else if (_chatCount == 2) {
          _messages.add(DreamMessage(
            text:
                "조금 더 깊이 들어가볼 수도 있어요.\n꿈속 상황이나 감정이 어땠는지 더 얘기해주시면 해석이 더 풍부해질 수 있답니다 :)\n이제 마지막 질문 기회예요!",
            isUser: false,
          ));
        } else if (_chatCount == 3) {
          _messages.add(DreamMessage(
            text: "꿈 해몽 질문은 하루에 한 번만 가능해요. 신중하게 질문해주세요! 더 궁금하면 낼 찾아오슈",
            isUser: false,
          ));
        }
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
                  "꿈 해몽은 하루에 한 번만 가능해요! 궁금하다면 내일 다시 찾아와주세요.",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
