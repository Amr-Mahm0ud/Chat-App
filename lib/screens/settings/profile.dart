import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as cloud_storage;
import 'package:flutter/material.dart';
import '/models/user.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              child: Center(
                child: CircleAvatar(
                  radius: size.width * 0.2,
                  backgroundImage: userData.image.isEmpty
                      ? null
                      : NetworkImage(userData.image),
                  child: Align(
                    alignment: const Alignment(1, 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          buildBottomSheet(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              tag: 'profilePic',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Personal Information',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  buildTiles('Name', userData.name, Icons.person, () {}),
                  const Divider(),
                  buildTiles(
                      'E-Mail', userData.email, Icons.email_rounded, () {}),
                  const Divider(),
                  buildTiles('Bio', userData.status, Icons.info_rounded, () {}),
                ],
              ),
            ),
            const SizedBox(height: 5),
            ListTile(
              tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('logout'),
              trailing: const Icon(Icons.logout_rounded),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildTiles(String title, String subtitle, IconData icon, method) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
      onTap: method,
    );
  }

  void buildBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 5,
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: Text(
                'Profile Picture',
                style: Theme.of(ctx).textTheme.headline6,
              ),
            ),
            Row(
              children: [
                const Spacer(flex: 2),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Theme.of(context).iconTheme.color!),
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.photo_rounded,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      pickImage(ImageSource.gallery, context);
                    },
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Theme.of(context).iconTheme.color!),
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_rounded,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      pickImage(ImageSource.camera, ctx);
                      Navigator.of(ctx).pop();
                    },
                  ),
                ),
                const Spacer(flex: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource src, BuildContext context) async {
    final XFile? pickedImage =
        await picker.pickImage(source: src, imageQuality: 50);
    if (pickedImage != null) {
        image = File(pickedImage.path);
      try {
        cloud_storage.Reference ref = cloud_storage.FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('${userData.email}.jpg');
        await ref.putFile(image!);
        final imgUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userData.email)
            .update({'image': imgUrl});
        setState(() {
          userData.image = imgUrl;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      }
    }
  }
}
