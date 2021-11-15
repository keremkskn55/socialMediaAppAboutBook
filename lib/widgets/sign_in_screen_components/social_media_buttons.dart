import 'package:flutter/material.dart';
import '../../constants.dart';

class AppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('Apple Button was clicked');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: size.width - 36,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/icons8-apple-logo-48.png'),
                ),
              ),
            ),
            Text(
              'Continue With Apple',
              style: Constants().r20black,
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print('Google Button was clicked');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: size.width - 36,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/icons8-google-60.png'),
                ),
              ),
            ),
            Text(
              'Continue With Google',
              style: Constants().r20black,
            ),
          ],
        ),
      ),
    );
  }
}
