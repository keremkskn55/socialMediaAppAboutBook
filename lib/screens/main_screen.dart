import 'package:book_app/models/user.dart';
import 'package:book_app/screens/adding_book_screen.dart';
import 'package:book_app/screens/main_screen_view_model.dart';
import 'package:book_app/services/auth.dart';
import 'package:book_app/widgets/main_screen_components/logout_notifications_profile.dart';
import 'package:book_app/widgets/main_screen_components/sharing_in_main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  String currentUsername;
  MainScreen({required this.currentUsername});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late User currentUser;

  void buildSetState() {
    setState(() {});
    print('asdasd');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MainScreenViewModel>(
      create: (_) => MainScreenViewModel(),
      builder: (context, _) => StreamBuilder<DocumentSnapshot>(
        stream: Provider.of<MainScreenViewModel>(context, listen: false)
            .getUserInfo(widget.currentUsername),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error...');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          currentUser = User.fromMap(data);

          return SafeArea(
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddingBookScreen(
                                username: currentUser.username,
                                user: currentUser,
                              ))).then((value) => setState(() {}));
                },
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Constants().blackBlue,
              ),
              body: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Constants().blackBlue,
                      Constants().blue,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    /// Top Components - Logout, Notifications, Profile
                    LogoutNotificationsProfile(
                      profilePhotoUrl: currentUser.profilePhotoUrl,
                    ),

                    /// Divider
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        height: 30,
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),

                    /// Sharing
                    SharingInMainScreen(
                      mainUser: currentUser,
                      callback: buildSetState,
                      isMainScreen: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
