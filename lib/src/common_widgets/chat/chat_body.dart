import 'package:benji/src/repo/models/chat/chat.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';

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
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) {
                return Message(
                  message: demoChatMessages[index],
                );
              },
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return const Text("Chat Text");
  }
}
