import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '/screens/messages/chat_body.dart';
import '/models/chat_model.dart';

class AllChats extends StatefulWidget {
  const AllChats({Key? key}) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  bool isInChats = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(
              left: 5,
              top: 5,
              right: MediaQuery.of(context).size.width * 0.4,
              bottom: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton(context, 'All Chats', isInChats, () {
                setState(() {
                  if (!isInChats) isInChats = !isInChats;
                });
              }),
              buildButton(context, 'Favorites', !isInChats, () {
                setState(() {
                  if (isInChats) isInChats = !isInChats;
                });
              })
            ],
          ),
        ),
        isInChats ? buildRecentMessages(context) : buildFavorites(context),
      ],
    );
  }

  Widget buildButton(
      BuildContext context, String title, bool isFilled, VoidCallback press) {
    return MaterialButton(
      onPressed: press,
      color: isFilled ? Colors.white : Theme.of(context).primaryColor,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: isFilled ? Theme.of(context).primaryColor : Colors.white),
      ),
      elevation: 0,
      shape: isFilled
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(width: 1.5, color: Colors.white)),
    );
  }

  Expanded buildRecentMessages(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...chatsData.where((chat) => chat.isSeen == false).map(
                (chat) => Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            chatsData.remove(chat);
                          });
                        },
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          if (!favorites.contains(chat)) {
                            setState(() {
                              favorites.add(chat);
                            });
                          }
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        icon: Icons.favorite,
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatBody(chat),
                      ));
                    },
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
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Expanded buildFavorites(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...favorites.map(
            (chat) => Slidable(
              closeOnScroll: true,
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        favorites.remove(chat);
                      });
                    },
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Colors.white,
                    icon: Icons.outbox,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChatBody(chat)));
                },
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
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
