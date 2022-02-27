import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamam_zagl/components/chats/message_bubble.dart';

class AllMessages extends StatefulWidget {
  final String link;
  const AllMessages(this.link, {Key? key}) : super(key: key);

  @override
  State<AllMessages> createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats/${widget.link}/messages')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(
              alignment: Alignment.topCenter, child: LinearProgressIndicator());
        } else if (snapshot.data == null) {
          return const Text('empty');
        } else {
          final docs = snapshot.data!.docs;
          return docs.isEmpty
              ? const Center(child: Text('No messages yet'))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  child: ListView(
                    reverse: true,
                    children: [
                      ...docs.map((message) {
                        return MessageBubble(message);
                      })
                    ],
                  ),
                );
        }
      },
    );
  }
}
