import 'package:flutter/material.dart';
import 'package:haengunse/service/dream/dream_service.dart';
import 'package:haengunse/service/dream/dream_message.dart';
import 'package:haengunse/screens/dream/animated_dots.dart';

class DreamChatBox extends StatefulWidget {
  const DreamChatBox({super.key});

  @override
  State<DreamChatBox> createState() => _DreamChatBoxState();
}

class _DreamChatBoxState extends State<DreamChatBox> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<DreamMessage> _messages = [];
  final List<GlobalKey> _messageKeys = [];
  int _chatCount = 0;

  @override
  void initState() {
    super.initState();
    _addSystemMessage(
        "꿈은 마음이 보내는 반짝이는 메시지일지도 몰라요. 어떤 꿈이었는지 저에게 살짝 들려주신다면, 해석해드릴게요.");
  }

  void _addSystemMessage(String text) {
    setState(() {
      _messages.add(DreamMessage(text: text, isUser: false));
      _messageKeys.add(GlobalKey());
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(DreamMessage(text: text, isUser: true));
      _messageKeys.add(GlobalKey());
    });
    _scrollToBottom();
  }

  void _scrollToBottom({bool smooth = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      Future.delayed(const Duration(milliseconds: 30), () {
        final offset = _scrollController.position.maxScrollExtent;
        if (smooth) {
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
          );
        } else {
          _scrollController.jumpTo(offset);
        }
      });
    });
  }

  void _retryMessage(String input) {
    // 기존 에러 메시지 제거
    setState(() {
      final index = _messages.indexWhere(
        (m) => m.isUser && m.text == input && m.isError,
      );
      if (index != -1) {
        _messages.removeAt(index);
        _messageKeys.removeAt(index);
      }
    });

    // 재전송
    _sendMessage(input);
  }

  bool _isWaitingResponse = false;

  void _sendMessage(String input) async {
    if (input.trim().isEmpty || _chatCount >= 3 || _isWaitingResponse) return;

    setState(() {
      _isWaitingResponse = true;
      _messages.add(DreamMessage(text: input, isUser: true));
      _messageKeys.add(GlobalKey());

      _messages.add(DreamMessage(
        text: "loading",
        isUser: false,
        isLoading: true,
      ));
      _messageKeys.add(GlobalKey());
    });

    _controller.clear();

    final history = _messages
        .where((m) => m.isUser && !m.isError)
        .map((m) => m.text)
        .toList();
    final result = await DreamService.sendDream(history);

    // 일단 로딩 메시지는 제거
    setState(() {
      final last = _messages.isNotEmpty ? _messages.last : null;
      if (last != null && last.isLoading) {
        _messages.removeLast();
        _messageKeys.removeLast();
      }
    });

    if (result.reply != null) {
      setState(() {
        _messages.add(DreamMessage(text: result.reply!, isUser: false));
        _messageKeys.add(GlobalKey());
      });

      _chatCount++;

      // 👉 템플릿 메시지 딜레이 + 그 이후에만 응답 허용
      if (_chatCount == 1) {
        await Future.delayed(const Duration(milliseconds: 300));
        _addSystemMessage("꿈속에서 느꼈던 감정이나 더 자세한 상황을 알려주시면...");
      } else if (_chatCount == 2) {
        await Future.delayed(const Duration(milliseconds: 300));
        _addSystemMessage("조금 더 깊이 들어가볼 수도 있어요...");
      } else if (_chatCount == 3) {
        await Future.delayed(const Duration(milliseconds: 300));
        _addSystemMessage("꿈 해몽 질문은 하루에 한 번만 가능해요...");
      }

      setState(() {
        _isWaitingResponse = false;
      });
    } else if (result.isNetworkError) {
      setState(() {
        _isWaitingResponse = false; // 실패 시에도 반드시 해제
        _messages.removeLast(); // loading 제거
        _messageKeys.removeLast();
        _messages.add(DreamMessage(text: input, isUser: true, isError: true));
        _messageKeys.add(GlobalKey());
      });
    } else {
      setState(() {
        _isWaitingResponse = false;
      });
      _addSystemMessage("죄송해요. 지금은 해석을 도와드릴 수 없어요.");
    }

    _scrollToBottom();
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
              child: NotificationListener<ScrollNotification>(
                onNotification: (_) {
                  setState(() {});
                  return false;
                },
                child: RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: false,
                  thickness: 6,
                  radius: const Radius.circular(10),
                  thumbColor: Colors.white,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isNetworkError = message.isUser && message.isError;

                      return Align(
                        key: _messageKeys[index],
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: message.isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: message.isUser
                                    ? Colors.green[100]
                                    : Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: message.isLoading
                                  ? const AnimatedDots()
                                  : Text(
                                      message.text,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                            ),
                            if (isNetworkError)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _messages.removeAt(index);
                                          _messageKeys.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      label: const Text("취소",
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        final originalText = message.text;

                                        setState(() {
                                          _messages.removeAt(index);
                                          _messageKeys.removeAt(index);
                                        });

                                        _sendMessage(originalText);
                                      },
                                      icon: const Icon(Icons.refresh,
                                          color: Colors.blue),
                                      label: const Text("다시 시도",
                                          style: TextStyle(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (_chatCount < 3)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) => _sendMessage(value),
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
