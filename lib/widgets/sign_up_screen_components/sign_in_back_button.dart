import 'package:book_app/constants.dart';
import 'package:book_app/screens/sign_in_screen.dart';
import 'package:book_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Constants().blackBlue,
            fixedSize: Size((size.width * 0.66), 36),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('You have an account'),
        ),
      ),
    );
  }
}
