enum ChatMessageType { text, audio, image, video }

class ChatMessage {
  String text;
  final String sender;

  ChatMessage({
    required this.text,
    required this.sender,
  });
}
