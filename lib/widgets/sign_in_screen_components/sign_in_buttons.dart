import 'package:book_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SignInButton extends StatelessWidget {
  String email;
  String password;
  GlobalKey<FormState> signInKey;
  Function callback;

  SignInButton({
    required this.email,
    required this.password,
    required this.signInKey,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF3A6073),
        fixedSize: Size(96, 36),
      ),
      onPressed: () async {
        if (signInKey.currentState!.validate()) {
          try {
            await Provider.of<Auth>(context, listen: false)
                .signInWithEmail(email, password);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
              callback('No user found for that email');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
              callback('Wrong password provided for that user.');
            }
          }
        }
      },
      child: Text(
        'Sign In',
        style: Constants().r16white,
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Forgot password was clicked');
      },
      child: Text(
        'Forgot Password',
        style: Constants().b16green,
      ),
    );
  }
}
