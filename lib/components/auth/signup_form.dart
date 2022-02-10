import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      child: Form(
        onChanged: () {},
        child: Column(
          children: [
            const Spacer(),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.30),
                hintText: 'Enter your email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 2),
                ),
                border: InputBorder.none,
              ),
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.30),
                hintText: 'Enter your password',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 2),
                ),
                border: InputBorder.none,
              ),
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.30),
                hintText: 'Confirm your password',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 2),
                ),
                border: InputBorder.none,
              ),
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
