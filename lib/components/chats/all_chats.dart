import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hamam_zagl/models/user.dart';
import '/screens/messages/chat_body.dart';

class AllChats extends StatefulWidget {
  const AllChats({Key? key}) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  bool isInChats = true;
  List favorites = [];
  @override
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
          margin: const EdgeInsets.only(bottom: 5),
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
        isInChats
            ? buildRecentMessages(context)
            : const Text('lsa wallahi asa7bi')
        // buildFavorites(context),
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

  Widget buildRecentMessages(BuildContext context) {
    String user2Id = '';
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            // .where('members', arrayContains: userData.email)
            // .where('lastMes', isNotEqualTo: '')
            .orderBy('lastMesTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else if (snapshot.data == null) {
            return const Center(child: Text('You have no chats'));
          } else {
            final docs = snapshot.data!.docs;
            docs.removeWhere((chat) => chat['lastMes'] == '');
            return Expanded(
              child: docs.isEmpty
                  ? const Center(child: Text('You have no chats'))
                  : ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        if (docs[index]['members'][0] == userData.email) {
                          user2Id = docs[index]['members'][1];
                        } else {
                          user2Id = docs[index]['members'][0];
                        }
                        DateTime time = DateTime.parse(
                            docs[index]['lastMesTime'].toDate().toString());
                        int lastTime =
                            DateTime.now().difference(time).inMinutes;
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('users')
                              .doc(user2Id)
                              .get(),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            } else if (snapshot2.data == null) {
                              return const Center(
                                  child: Text('You have no chats'));
                            } else {
                              final user2 = snapshot2.data!.data()
                                  as Map<String, dynamic>;
                              bool isYourChat = user2Id == userData.email;
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('chats')
                                              .doc(docs[index]['id'])
                                              .delete()
                                              .then(
                                                (res) => ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text('chat deleted'),
                                                  ),
                                                ),
                                              );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('error occurred'),
                                            ),
                                          );
                                        }
                                      },
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        if (!favorites.contains(docs[index])) {
                                          setState(() {
                                            favorites.add(docs[index]);
                                          });
                                        }
                                      },
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.favorite,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ChatBody(user2, docs[index]['id']),
                                    ));
                                  },
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.blueGrey[300],
                                    child: const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title:
                                      Text(isYourChat ? 'You' : user2['name']),
                                  subtitle: Text(docs[index]['lastMes']),
                                  trailing: Text(lastTime == 0
                                      ? 'just now'
                                      : lastTime < 60
                                          ? '$lastTime min ago'
                                          : lastTime < 1440
                                              ? '${(lastTime / 60).floor()} h ago'
                                              : 'days ago'),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
            );
          }
        });
  }

  Expanded buildFavorites(BuildContext context) {
    return Expanded(
      child: favorites.isEmpty
          ? const Center(child: Text('You have no favorite chats'))
          : ListView(
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatBody(chat, chat['id']),
                        ));
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueGrey[300],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(chat['name']),
                      subtitle: Text(chat.status),
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
