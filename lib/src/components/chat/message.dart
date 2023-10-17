import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constant.dart';
import '../../repo/models/chat/chat.dart';
import 'chat_bubble.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: deviceType(media.width) > 2 ? 16 : 12,
              backgroundColor: kLightGreyColor,
              backgroundImage: const AssetImage("assets/icons/support.png"),
            )
          ],
          ChatBubble(message: message),
        ],
      ),
    );
  }
}
