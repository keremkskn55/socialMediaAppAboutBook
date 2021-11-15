import 'package:flutter/material.dart';

import '../../constants.dart';

class AddingBookBackAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Text(
          'ADDING BOOK',
          style: Constants().r20white,
        ),
        Opacity(
            opacity: 0,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.save))),
      ],
    );
  }
}
