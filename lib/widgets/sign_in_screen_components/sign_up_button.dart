import 'package:book_app/constants.dart';
import 'package:book_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0, right: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Constants().blackBlue,
            fixedSize: Size((size.width * 0.66), 36),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          },
          child: Text('You don\'t have any account'),
        ),
      ),
    );
  }
}
