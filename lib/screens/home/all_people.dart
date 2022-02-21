import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamam_zagl/models/user.dart';
import 'package:hamam_zagl/screens/messages/chat_body.dart';

class AllPeople extends StatelessWidget {
  const AllPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (snapshot.data == null) {
          return const Text('No users are here');
        } else {
          final docs = snapshot.data!.docs;
          return ListView(
            children: [
              ...docs.map(
                (user) {
                  DateTime time = DateTime.parse(user['lastSeen'].toString());
                  int lastTime = DateTime.now().difference(time).inMinutes;
                  return ListTile(
                    leading: user['image'].toString().isEmpty
                        ? CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blueGrey[300],
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(user['image']),
                          ),
                    title: Text(
                        user['email'] == userData.email ? 'You' : user['name']),
                    subtitle: Text(user['status']),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(lastTime < 60
                            ? '$lastTime min ago'
                            : lastTime < 1440
                                ? '${(lastTime / 60).floor()} h ago'
                                : 'days ago'),
                      ],
                    ),
                    onTap: () {
                      createChat(user, context);
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> createChat(var user, context) async {
    try {
      String link = '${user['email']}${userData.email}';
      FirebaseFirestore.instance
          .collection('chats')
          .doc(link)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatBody(user, link),
          ));
        } else {
          link = '${userData.email}${user['email']}';
          FirebaseFirestore.instance
              .collection('chats')
              .doc('${userData.email}${user['email']}')
              .set({
            'id': link,
            'lastMes': '',
            'lastMesTime': DateTime.now(),
            'members': [userData.email, user['email']],
          });
          FirebaseFirestore.instance
              .collection('chats')
              .doc('${userData.email}${user['email']}')
              .collection('messages');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatBody(user, link),
          ));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('SomeThing went wrong'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }
}
