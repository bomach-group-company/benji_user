enum ChatMessageType { text, audio, image, video }

enum MessageStatus { notSent, sent, delivered, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List demoChatMessages = [
  ChatMessage(
    text: "Hello, how are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "I'm good, how are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "I'm good as well",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "How's your day going?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessage(
    text: "Oh it's going fine",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "What about you??",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
];
