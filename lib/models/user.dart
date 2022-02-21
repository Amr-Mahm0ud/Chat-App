import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String email;
  String password;
  String image;
  String status;
  String lastSeen;
  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.image,
      required this.lastSeen,
      required this.status});
}

User userData = User(
    name: '',
    email: '',
    password: '',
    image: '',
    status: 'Hey there',
    lastSeen: DateTime.now().toUtc().toString());
getUserData() {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get()
          .then((doc) {
        if (doc.exists) {
          userData = User(
            name: doc['name'],
            email: doc['email'],
            password: doc['password'],
            image: doc['image'],
            status: doc['status'],
            lastSeen: doc['lastSeen'],
          );
        }
      });
    }
  });
}
