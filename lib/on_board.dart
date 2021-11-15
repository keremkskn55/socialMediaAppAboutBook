import 'package:book_app/screens/main_screen.dart';
import 'package:book_app/screens/sign_in_screen.dart';
import 'package:book_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    final _authStatusControl =
        Provider.of<Auth>(context, listen: false).authStatusControl();
    return StreamBuilder(
      stream: _authStatusControl,
      initialData: Center(child: CircularProgressIndicator()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print('stage is changing');
        print(snapshot.data.toString());
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data == null
              ? SignInScreen()
              : MainScreen(
                  currentUsername: snapshot.data.displayName,
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
