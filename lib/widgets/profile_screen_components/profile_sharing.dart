import 'package:book_app/models/user.dart';
import 'package:flutter/material.dart';

class ProfileSharing extends StatefulWidget {
  User? user;
  bool isSameUser;

  ProfileSharing({
    required this.user,
    required this.isSameUser,
  });

  @override
  State<ProfileSharing> createState() => _ProfileSharingState();
}

class _ProfileSharingState extends State<ProfileSharing> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
