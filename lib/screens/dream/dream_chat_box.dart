import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/screens/dream/scroll_view.dart';
import 'package:haengunse/screens/dream/chat_input.dart';
import 'package:haengunse/screens/dream/network_error_dialog.dart';
import 'package:haengunse/service/dream/dream_chat_logic.dart';

class DreamChatBox extends StatefulWidget {
  const DreamChatBox({super.key});

  @override
  State<DreamChatBox> createState() => _DreamChatBoxState();
}

class _DreamChatBoxState extends State<DreamChatBox> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late final _chatController = DreamChatBoxController(
    scrollController: _scrollController,
    onUpdate: () => setState(() {}),
    onShowErrorDialog: () {
      showDialog(
        context: context,
        builder: (context) => const NetworkErrorDialog(),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    _chatController.init();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        Image.asset(
          'assets/images/dream_background.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            children: [
              Expanded(
                child: DreamScrollView(
                  scrollController: _scrollController,
                  messages: _chatController.messages,
                  messageKeys: _chatController.messageKeys,
                  onCancel: _chatController.cancelMessage,
                  onRetry: _chatController.retryMessage,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: _chatController.chatCount < 3
                    ? DreamChatInput(
                        controller: _controller,
                        onSend: () => _chatController.sendMessage(
                            _controller.text, _controller),
                      )
                    : const LimitMessageBox(),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ],
    );
  }
}
