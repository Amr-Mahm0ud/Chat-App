import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/components/auth/signup_form.dart';
import '/screens/home/home_page.dart';
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
        body: Stack(
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
                  color: Theme.of(context).colorScheme.primary,
                  child: const SignInForm(),
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
                  child: const SignUpForm(),
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
                    MediaQuery.of(context).platformBrightness == Brightness.dark
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
              child: Transform.rotate(
                angle: -_rotationAnimation.value * pi / 180,
                child: SizedBox(
                  width: _size.width * 0.44,
                  child: TextButton(
                      style: _isSignIn
                          ? TextButton.styleFrom().copyWith(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white30),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent))
                          : TextButton.styleFrom().copyWith(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3))),
                      child: AnimatedDefaultTextStyle(
                        duration: _duration,
                        style: _isSignIn
                            ? Theme.of(context).textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 40)
                            : Theme.of(context).textTheme.headline6!,
                        child: Text(
                          'Sign In'.toUpperCase(),
                        ),
                      ),
                      onPressed: _isSignIn
                          ? () {
                              authenticate(context);
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
              child: Transform.rotate(
                angle: (-_rotationAnimation.value + 90) * pi / 180,
                child: SizedBox(
                  width: _size.width * 0.48,
                  child: TextButton(
                      style: _isSignIn
                          ? TextButton.styleFrom().copyWith(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent))
                          : TextButton.styleFrom().copyWith(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3))),
                      child: AnimatedDefaultTextStyle(
                        duration: _duration,
                        style: !_isSignIn
                            ? Theme.of(context).textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 40)
                            : Theme.of(context).textTheme.headline6!,
                        child: Text(
                          'Sign Up'.toUpperCase(),
                        ),
                      ),
                      onPressed: !_isSignIn
                          ? () {
                              authenticate(context);
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
    );
  }

  void authenticate(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
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
