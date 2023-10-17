import 'package:benji/src/repo/models/chat/chat.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'chat_input_field.dart';
import 'message.dart';

class ChatBody extends StatelessWidget {
  ChatBody({super.key});
  //============================================== ALL VARIABLES =================================================\\

//============================================== BOOL VALUES =================================================\\

//============================================== CONTROLLERS =================================================\\
  final _scrollController = ScrollController();

//============================================== FUNCTIONS =================================================\\

//============================================== NAVIGATION =================================================\\

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "You are connected to our Agent.",
          style: TextStyle(
            color: kGreyColor1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Divider(color: kLightGreyColor),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) {
                return Message(message: demoChatMessages[index]);
              },
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
