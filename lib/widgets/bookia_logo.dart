import 'package:flutter/material.dart';

class BookiaLogo extends StatelessWidget {
  const BookiaLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(
            'assets/logo/bookia_logo_text.png',
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
