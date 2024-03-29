import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import '/components/chats/all_chats.dart';
import 'all_people.dart';
import 'search.dart';
import '/screens/settings/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'HomeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(_currentIndex == 0
            ? 'Chats'
            : _currentIndex == 1
                ? 'People'
                : _currentIndex == 2
                    ? 'Stories'
                    : 'Profile'),
        actions: [
          AnimSearchBar(
            prefixIcon: const Icon(Icons.search),
            color: Theme.of(context).primaryColor,
            onSuffixTap: () {},
            suffixIcon: const Icon(Icons.search),
            textController: TextEditingController(),
            width: _size.width,
          )
        ],
      ),
      body: _currentIndex == 0
          ? const AllChats()
          : _currentIndex == 1
              ? const AllPeople()
              : _currentIndex == 2
                  ? const StoriesPage()
                  : const Profile(),
      floatingActionButton: _currentIndex == 1 || _currentIndex == 3
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: const Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), label: 'Stories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
        onTap: (newVal) {
          setState(() {
            _currentIndex = newVal;
          });
        },
      ),
      // drawer: Drawer(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Theme.of(context).primaryColor,
      //         alignment: Alignment.center,
      //         height: _size.height * 0.15,
      //         child: SafeArea(
      //           child: ListTile(
      //             onTap: () {},
      //             title: Text(
      //               'Amr Mahmoud',
      //               style: Theme.of(context).textTheme.headline6,
      //             ),
      //             subtitle: Text(
      //               'amrmahmoud@gmail.com',
      //               style: Theme.of(context).textTheme.subtitle2,
      //             ),
      //             leading: CircleAvatar(
      //               radius: 30,
      //               child: Image.asset('assets/images/user_2.png'),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
