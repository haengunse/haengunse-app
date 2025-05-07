import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/dream/dream_message.dart';
import 'package:haengunse/screens/dream/user_bubble.dart';
import 'package:haengunse/screens/dream/system_bubble.dart';
import 'package:haengunse/screens/dream/retry_buttons.dart';

class DreamScrollView extends StatefulWidget {
  final ScrollController scrollController;
  final List<DreamMessage> messages;
  final List<GlobalKey> messageKeys;
  final void Function(int index) onRetry;
  final void Function(int index) onCancel;

  const DreamScrollView({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.messageKeys,
    required this.onRetry,
    required this.onCancel,
  });

  @override
  State<DreamScrollView> createState() => _DreamScrollViewState();
}

class _DreamScrollViewState extends State<DreamScrollView> {
  @override
  void initState() {
    super.initState();
    // 최초 진입 시 자동 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(covariant DreamScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 메시지 업데이트 시 자동 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (!widget.scrollController.hasClients) return;

    final position = widget.scrollController.position;
    widget.scrollController.animateTo(
      position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: widget.scrollController,
      thumbVisibility: false,
      thickness: 6.w,
      radius: Radius.circular(10.r),
      thumbColor: Colors.white,
      child: ListView.builder(
          controller: widget.scrollController,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            top: 0.h,
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),
          itemCount: widget.messages.length,
          itemBuilder: (context, index) {
            final message = widget.messages[index];
            final isNetworkError = message.isUser && message.isError;

            return Align(
              key: widget.messageKeys[index],
              alignment:
                  message.isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: message.isUser
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isNetworkError)
                          RetryButtons(
                            index: index,
                            onCancel: widget.onCancel,
                            onRetry: widget.onRetry,
                          ),
                        SizedBox(width: 6.w),
                        UserBubble(message: message),
                      ],
                    )
                  : SystemBubble(message: message),
            );
          }),
    );
  }
}
