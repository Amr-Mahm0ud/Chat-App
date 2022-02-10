import 'package:flutter/material.dart';
import '/screens/auth/auth_screen.dart';

import '/theme/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset('assets/images/welcome_image.png'),
            const Spacer(flex: 3),
            Text(
              'Welcome to our freedom \n messaging app',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text('Freedom talk to any person of your \n mother language',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.65))),
            const Spacer(flex: 2),
            FittedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ));
                },
                child: Row(
                  children: [
                    Text('Next',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8),
                            fontSize: 17)),
                    const SizedBox(width: kDefaultPadding / 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
