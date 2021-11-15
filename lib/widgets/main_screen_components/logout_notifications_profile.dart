import 'package:book_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutNotificationsProfile extends StatelessWidget {
  String profilePhotoUrl;
  LogoutNotificationsProfile({required this.profilePhotoUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await Provider.of<Auth>(context, listen: false).signOut();
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            print('notification button was pressed');
          },
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            right: 8.0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
              ),
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(37)),
                  image: DecorationImage(
                      image: NetworkImage(profilePhotoUrl), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
