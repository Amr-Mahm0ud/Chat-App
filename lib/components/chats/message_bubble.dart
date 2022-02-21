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
  // bool showTime = false;

  @override
  Widget build(BuildContext context) {
    bool isSender = widget.message['sender'] == userData.email;
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: widget.message['sender'] == userData.email
                  ? Theme.of(context).colorScheme.secondary
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
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 350),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
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
                // if (showTime) const SizedBox(height: 5),
                // if (showTime)
                //   Text(
                //     displayTime,
                //     style: Theme.of(context)
                //         .textTheme
                //         .subtitle2!
                //         .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                //   ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
