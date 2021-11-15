import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/profile_screen_components/profile_screen_sharings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenSharings extends StatefulWidget {
  User mainUser;
  User? profileOwnUser;
  ProfileScreenSharings({
    required this.mainUser,
    required this.profileOwnUser,
  });

  @override
  _ProfileScreenSharingsState createState() => _ProfileScreenSharingsState();
}

class _ProfileScreenSharingsState extends State<ProfileScreenSharings> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenSharingsViewModel>(
      create: (context) => ProfileScreenSharingsViewModel(),
      builder: (context, _) => StreamBuilder<List<Sharing>>(
        stream:
            Provider.of<ProfileScreenSharingsViewModel>(context, listen: false)
                .getSharingList(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            print(asyncSnapshot.error);
            return Center(
              child: Text('There is an error. Try again!!!'),
            );
          } else {
            if (!asyncSnapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              List<Sharing>? sharingList = asyncSnapshot.data;
              return BuildListOfSharings(
                sharingList: sharingList,
                currentUser: widget.mainUser,
                profileOwnUser: widget.profileOwnUser,
              );
            }
          }
        },
      ),
    );
  }
}

class BuildListOfSharings extends StatefulWidget {
  List? sharingList;
  User currentUser;
  User? profileOwnUser;

  BuildListOfSharings({
    required this.profileOwnUser,
    required this.currentUser,
    required this.sharingList,
  });

  @override
  _BuildListOfSharingsState createState() => _BuildListOfSharingsState();
}

class _BuildListOfSharingsState extends State<BuildListOfSharings> {
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.red,
    //     ),
    //     Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.red,
    //     ),
    //     Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.red,
    //     ),
    //     Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.red,
    //     ),
    //   ],
    // );
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
    );
  }
}
