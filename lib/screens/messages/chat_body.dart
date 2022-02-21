// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hamam_zagl/components/chats/all_messages.dart';
import 'package:hamam_zagl/components/chats/new_messages.dart';

class ChatBody extends StatefulWidget {
  final chat;
  final link;
  const ChatBody(this.chat, this.link, {Key? key}) : super(key: key);

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
              backgroundColor: Colors.blueGrey[300],
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              widget.chat['name'],
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.videocam_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: AllMessages(widget.link)),Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: NewMessage(widget.link)),
        ],
      ),
    );
  }
}
