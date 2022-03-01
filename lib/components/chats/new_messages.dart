import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamam_zagl/models/chat_message.dart';
import 'package:hamam_zagl/models/user.dart';

class NewMessage extends StatefulWidget {
  final String link;
  const NewMessage(this.link, {Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController controller = TextEditingController();
  ChatMessage newMes = ChatMessage(
    text: '',
    sender: userData.email,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.2))),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.emoji_emotions_outlined),
                onPressed: () {},
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: InputBorder.none,
                    labelText: 'Message...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      newMes.text = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_voice),
                onPressed: () {},
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: controller.text.isEmpty
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
          radius: 25,
          child: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.send),
            onPressed: controller.text.isEmpty ? null : sendMessage,
          ),
        )
      ],
    );
  }

  void sendMessage() async {
    Timestamp time = Timestamp.now();
    FocusScope.of(context).unfocus();
    controller.clear();
    await FirebaseFirestore.instance
        .collection('chats/${widget.link}/messages')
        .add({'text': newMes.text, 'sender': newMes.sender, 'time': time});
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.link)
        .update({'lastMes': newMes.text, 'lastMesTime': time});
  }
}
