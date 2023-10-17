import 'package:flutter/material.dart';

import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../theme/colors.dart';
import '../../repo/models/chat/chat.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: message.text,
      textStyle: TextStyle(
          color: message.isSender
              ? kPrimaryColor
              : Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 16),
      color: message.isSender ? kAccentColor : kAccentColor.withOpacity(0.08),
      isSender: message.isSender,
    );
  }
}
