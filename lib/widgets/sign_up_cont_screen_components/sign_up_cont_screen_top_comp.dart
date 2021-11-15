import 'package:flutter/material.dart';

class SignUpcContScreenTopComp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 40,
          width: size.width / 2,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(
                'assets/logo/bookia_logo_text.png',
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
