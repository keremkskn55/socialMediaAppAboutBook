import 'package:flutter/material.dart';

import '../../constants.dart';

class SignContButtonFake extends StatelessWidget {
  const SignContButtonFake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 18.0),
      child: Align(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF44CA62).withOpacity(0.15),
            fixedSize: Size(96, 36),
          ),
          onPressed: () {},
          child: Text(
            'Sign Up',
            style: Constants().r16white,
          ),
        ),
      ),
    );
  }
}
