import 'package:flutter/material.dart';
import 'package:hamam_zagl/models/user.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      child: Column(
        children: [
          const Spacer(),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              filled: true,
              fillColor: Colors.white24,
              hintText: 'Email',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary, width: 2),
              ),
              border: InputBorder.none,
            ),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty ||
                  !value.contains('@') ||
                  !value.contains('.com')) return 'enter a valid email';
            },
            onSaved: (newValue) {
              userData['email'] = newValue!;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              filled: true,
              fillColor: Colors.white24,
              hintText: 'Password',
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
            validator: (value) {
              if (value!.isEmpty || value.length < 8) return 'wrong password';
            },
            onSaved: (newValue) {
              userData['password'] = newValue!;
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom().copyWith(
              overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.white30),
            ),
            onPressed: () {},
            child: Text(
              'Forgot Password ?',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
