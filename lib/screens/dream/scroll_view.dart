import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/dream/dream_message.dart';
import 'package:haengunse/screens/dream/user_bubble.dart';
import 'package:haengunse/screens/dream/system_bubble.dart';
import 'package:haengunse/screens/dream/retry_buttons.dart';

class DreamScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final List<DreamMessage> messages;
  final List<GlobalKey> messageKeys;
  final void Function(String input) onRetry;
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
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: scrollController,
      thumbVisibility: false,
      thickness: 6.w,
      radius: Radius.circular(10.r),
      thumbColor: Colors.white,
      child: ListView.builder(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(
          top: 0.h,
          left: 16.w,
          right: 16.w,
          bottom: 16.h,
        ),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isNetworkError = message.isUser && message.isError;

          return Align(
            key: messageKeys[index],
            alignment:
                message.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                message.isUser
                    ? UserBubble(
                        message: message,
                      )
                    : SystemBubble(
                        message: message,
                      ),
                if (isNetworkError && message.isUser)
                  RetryButtons(
                    onCancel: () => onCancel(index),
                    onRetry: () => onRetry(message.text),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
