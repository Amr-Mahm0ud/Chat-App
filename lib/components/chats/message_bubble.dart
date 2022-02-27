import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamam_zagl/models/user.dart';

class MessageBubble extends StatefulWidget {
  final QueryDocumentSnapshot message;
  const MessageBubble(this.message, {Key? key}) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isSender = widget.message['sender'] == userData.email;
    Timestamp timeStamp = widget.message['time'];
    int time = DateTime.now().difference(timeStamp.toDate()).inMinutes;
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showTime = !showTime;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.message['sender'] == userData.email
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isSender
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(20),
              ),
            ),
            constraints: BoxConstraints(
                minWidth: size.width * 0.3, maxWidth: size.width * 0.85),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.message['text'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showTime) ...[
          const SizedBox(width: 5),
          Text(
            time == 0
                ? 'now'
                : time > 60
                    ? '${(time / 60).floor()} hours'
                    : time > 1440
                        ? '${(time / 1440).floor()} days'
                        : '$time min',
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
          ),
        ]
      ],
    );
  }
}
