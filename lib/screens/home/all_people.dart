import 'package:flutter/material.dart';
import '../../models/chat_model.dart';

class AllPeople extends StatelessWidget {
  const AllPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...chatsData.map(
          (chat) => ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(chat.image),
            ),
            title: Text(chat.name),
            subtitle: Text(chat.lastMessage),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(chat.time),
                if (!chat.isSeen)
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
