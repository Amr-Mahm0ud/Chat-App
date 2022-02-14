import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamam_zagl/models/user.dart';
import 'package:hamam_zagl/screens/home/home_page.dart';
import '/components/auth/signup_form.dart';
import '/components/auth/signin_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 300);
  bool _isSignIn = true;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void _setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _rotationAnimation =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  @override
  void initState() {
    _setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              //Sign in form
              AnimatedPositioned(
                duration: _duration,
                height: _size.height,
                width: _size.width * 0.88,
                left: _isSignIn ? 0 : -_size.width * 0.76,
                top: 0,
                child: GestureDetector(
                  onTap: _isSignIn
                      ? null
                      : () {
                          reverseAnimation();
                        },
                  child: Container(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    child: _isSignIn ? const SignInForm() : null,
                  ),
                ),
              ),
              //Sign Up form
              AnimatedPositioned(
                duration: _duration,
                height: _size.height,
                width: _size.width * 0.88,
                top: 0,
                left: _isSignIn ? _size.width * 0.88 : _size.width * 0.12,
                child: GestureDetector(
                  onTap: _isSignIn
                      ? () {
                          startAnimation();
                        }
                      : null,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: _isSignIn ? null : const SignUpForm(),
                  ),
                ),
              ),
              //Logo
              AnimatedPositioned(
                  duration: _duration,
                  top: _size.height * 0.1,
                  left: _isSignIn ? _size.width * 0.22 : _size.width * 0.34,
                  child: SizedBox(
                    width: _size.width * 0.44,
                    child: SvgPicture.asset(
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? 'assets/icons/Logo_dark_theme.svg'
                          : 'assets/icons/Logo_light_theme.svg',
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )),
              //Sign in button
              AnimatedPositioned(
                duration: _duration,
                top: _isSignIn ? _size.height * 0.7 : _size.height * 0.45,
                left: _isSignIn ? _size.width * 0.22 : -_size.width * 0.165,
                child: _isLoading && _isSignIn
                    ? const Padding(
                        padding: EdgeInsets.only(left: 60.0),
                        child: CircularProgressIndicator(),
                      )
                    : Transform.rotate(
                        angle: -_rotationAnimation.value * pi / 180,
                        child: SizedBox(
                          width: _size.width * 0.44,
                          child: TextButton(
                              style: _isSignIn
                                  ? TextButton.styleFrom().copyWith(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.white30),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent))
                                  : TextButton.styleFrom().copyWith(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.3))),
                              child: AnimatedDefaultTextStyle(
                                duration: _duration,
                                style: _isSignIn
                                    ? Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40)
                                    : Theme.of(context).textTheme.headline6!,
                                child: Text(
                                  'Sign In'.toUpperCase(),
                                ),
                              ),
                              onPressed: _isSignIn
                                  ? () {
                                      validation();
                                    }
                                  : () {
                                      reverseAnimation();
                                    }),
                        ),
                      ),
              ),
              //Sign up button
              AnimatedPositioned(
                duration: _duration,
                top: !_isSignIn ? _size.height * 0.7 : _size.height * 0.45,
                left: !_isSignIn ? _size.width * 0.32 : _size.width * 0.7,
                child: _isLoading && !_isSignIn
                    ? const Padding(
                        padding: EdgeInsets.only(left: 70.0),
                        child: CircularProgressIndicator(),
                      )
                    : Transform.rotate(
                        angle: (-_rotationAnimation.value + 90) * pi / 180,
                        child: SizedBox(
                          width: _size.width * 0.48,
                          child: TextButton(
                              style: _isSignIn
                                  ? TextButton.styleFrom().copyWith(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.transparent))
                                  : TextButton.styleFrom().copyWith(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.3))),
                              child: AnimatedDefaultTextStyle(
                                duration: _duration,
                                style: !_isSignIn
                                    ? Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40)
                                    : Theme.of(context).textTheme.headline6!,
                                child: Text(
                                  'Sign Up'.toUpperCase(),
                                ),
                              ),
                              onPressed: !_isSignIn
                                  ? () {
                                      validation();
                                    }
                                  : () {
                                      startAnimation();
                                    }),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validation() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      authentication();
    }
  }

  void authentication() async {
    UserCredential res;
    setState(() {
      _isLoading = true;
    });
    try {
      if (!_isSignIn) {
        res = await _auth.createUserWithEmailAndPassword(
            email: userData['email']!.trim(),
            password: userData['password']!.trim());
        await FirebaseFirestore.instance
            .collection('users')
            .doc(res.user!.uid)
            .set({
          'email': userData['email']!.trim(),
          'password': userData['password']!.trim()
        });
      } else {
        res = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userData['email']!.trim(),
            password: userData['password']!.trim());
      }
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error.isEmpty ? 'error occurred' : error,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void startAnimation() {
    setState(() {
      _isSignIn = !_isSignIn;
      _animationController.forward();
    });
  }

  void reverseAnimation() {
    setState(() {
      _isSignIn = !_isSignIn;
      _animationController.reverse();
    });
  }
}
