import 'package:flutter/material.dart';
import '/models/chat_model.dart';

class ChatBody extends StatefulWidget {
  final Chat chat;
  const ChatBody(this.chat, {Key? key}) : super(key: key);

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chat.image),
            ),
            const SizedBox(width: 10),
            Text(
              widget.chat.name,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_rounded), onPressed: () {}),
        ],
      ),
      body: null,
    );
  }
}
