import 'package:book_app/models/user.dart';
import 'package:book_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SharingDetailsProfilePhotoUsername extends StatefulWidget {
  User? user;
  User currentUser;
  Function callback;
  SharingDetailsProfilePhotoUsername({
    required this.user,
    required this.currentUser,
    required this.callback,
  });

  @override
  State<SharingDetailsProfilePhotoUsername> createState() =>
      _SharingDetailsProfilePhotoUsernameState();
}

class _SharingDetailsProfilePhotoUsernameState
    extends State<SharingDetailsProfilePhotoUsername> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool isSameUser = true;
        if (widget.user!.username != widget.currentUser.username) {
          isSameUser = false;
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      profileUser: widget.user,
                      isSameUser: isSameUser,
                      currentUser: widget.currentUser,
                    ))).then((value) => widget.callback());
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
              ),
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(37)),
                  image: DecorationImage(
                      image: NetworkImage(widget.user!.profilePhotoUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.user!.username,
            style: Constants().r16white,
          ),
        ],
      ),
    );
  }
}
