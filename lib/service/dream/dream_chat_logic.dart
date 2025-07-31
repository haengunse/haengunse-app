import 'package:flutter/material.dart';
import 'package:haengunse/service/dream/dream_chat_interactor.dart';
import 'package:haengunse/service/dream/dream_chat_storage.dart';
import 'package:haengunse/service/dream/dream_message.dart';

class DreamChatBoxController {
  final ScrollController scrollController;
  final VoidCallback onUpdate;
  final VoidCallback onShowErrorDialog;

  final List<DreamMessage> messages = [];
  final List<GlobalKey> messageKeys = [];
  int chatCount = 0;
  bool _isWaitingResponse = false;

  DreamChatBoxController({
    required this.scrollController,
    required this.onUpdate,
    required this.onShowErrorDialog,
  });

  void init() async {
    final (loadedMessages, loadedCount) = await DreamChatStorage.loadChat();

    final cleanedMessages = loadedMessages.where((m) => !m.isLoading).toList();

    messages.addAll(cleanedMessages);
    messageKeys
        .addAll(List.generate(cleanedMessages.length, (_) => GlobalKey()));
    chatCount = loadedCount;
    onUpdate();

    if (messages.isEmpty) {
      _addSystemMessage(
          "꿈은 마음이 보내는 반짝이는 메시지일지도 몰라요. 어떤 꿈이었는지 저에게 살짝 들려주신다면, 해석해드릴게요.");
    }
  }

  void _addSystemMessage(String text) {
    messages.add(DreamMessage(text: text, isUser: false));
    messageKeys.add(GlobalKey());
    DreamChatStorage.saveChat(messages, chatCount);
    _scrollToBottom();
    onUpdate();
  }

  void _scrollToBottom({bool smooth = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      Future.delayed(const Duration(milliseconds: 30), () {
        final offset = scrollController.position.maxScrollExtent;
        if (smooth) {
          scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
          );
        } else {
          scrollController.jumpTo(offset);
        }
      });
    });
  }

  void sendMessage(String input, TextEditingController controller) async {
    if (input.trim().isEmpty || chatCount >= 3 || _isWaitingResponse) return;

    _isWaitingResponse = true;
    messages.add(DreamMessage(text: input, isUser: true));
    messageKeys.add(GlobalKey());
    messages.add(DreamMessage(text: "loading", isUser: false, isLoading: true));
    messageKeys.add(GlobalKey());
    controller.clear();
    DreamChatStorage.saveChat(messages, chatCount);
    _scrollToBottom();
    onUpdate();

    final history = messages
        .where((m) => m.isUser && !m.isError)
        .map((m) => m.text)
        .toList();
    final result = await DreamChatInteractor.processChat(history);

    if (messages.isNotEmpty && messages.last.isLoading) {
      messages.removeLast();
      messageKeys.removeLast();
    }

    if (result.reply != null) {
      // 정상 응답 처리
      messages.add(DreamMessage(text: result.reply!, isUser: false));
      messageKeys.add(GlobalKey());
      chatCount++;

      await Future.delayed(const Duration(milliseconds: 300));
      if (chatCount == 1) {
        _addSystemMessage("꿈 속에서 느꼈던 감정이나 상황을 좀 더 알려주시면, 조금 더 정확하게 해석할 수 있어요.");
      } else if (chatCount == 2) {
        _addSystemMessage("조금만 더 설명해주시면, 당신에게 맞는 해석으로 도와드릴 수 있어요.");
      } else if (chatCount == 3) {
        _addSystemMessage("꿈 해몽은 하루에 한 번만 가능해요! 내일 다시 이야기해볼까요?");
      }

      _isWaitingResponse = false;
      DreamChatStorage.saveChat(messages, chatCount);
    } else if (result.isNetworkError) {
      // 네트워크 오류 처리
      messages.removeLast();
      messageKeys.removeLast();
      messages.add(DreamMessage(text: input, isUser: true, isError: true));
      messageKeys.add(GlobalKey());
      _isWaitingResponse = false;
      DreamChatStorage.saveChat(messages, chatCount);
      onUpdate();
      onShowErrorDialog();
    } else {
      // 서버 오류든 기타 오류든 모두 동일한 문구 출력
      _isWaitingResponse = false;
      _addSystemMessage("죄송해요. 지금은 해석을 도와드릴 수 없어요.");
    }

    onUpdate();
    _scrollToBottom();
  }

  void cancelMessage(int index) {
    messages.removeAt(index);
    messageKeys.removeAt(index);
    DreamChatStorage.saveChat(messages, chatCount);
    onUpdate();
  }

  void retryMessage(int index) {
    final originalText = messages[index].text;
    cancelMessage(index);
    sendMessage(originalText, TextEditingController(text: originalText));
  }
}
