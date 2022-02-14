// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamam_zagl/screens/auth/auth_screen.dart';
import 'package:hamam_zagl/screens/home/home_page.dart';
import 'screens/welcome.dart';
import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          Widget nextPage = const AuthScreen();
          if (snapshot.hasData) {
            nextPage = const HomePage();
          } else {
            nextPage = const WelcomeScreen();
          }
          return nextPage;
        },
      ),
    );
  }
}
