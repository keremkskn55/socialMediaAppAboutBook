import 'package:book_app/models/user.dart';
import 'package:book_app/screens/sign_up_cont_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SignUpContButton extends StatelessWidget {
  GlobalKey<FormState> signUpKey;
  TextEditingController signUpUsernameCtr;
  TextEditingController signUpEmailCtr;
  TextEditingController signUpPasswordCtr;
  TextEditingController signUpPasswordAgainCtr;
  List<User> userList;
  Function callback;

  SignUpContButton({
    required this.signUpUsernameCtr,
    required this.signUpEmailCtr,
    required this.signUpPasswordCtr,
    required this.signUpPasswordAgainCtr,
    required this.signUpKey,
    required this.callback,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    userList.isEmpty ? userList = [] : null;
    return Padding(
      padding: EdgeInsets.only(right: 18.0),
      child: Align(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF44CA62).withOpacity(0.44),
            fixedSize: Size(96, 36),
          ),
          onPressed: () {
            if (signUpKey.currentState!.validate()) {
              if (signUpPasswordCtr.text != signUpPasswordAgainCtr.text) {
                _showAlertDialog(context, 'ERROR', 'Passwords are not same!');
              } else {
                bool isError = false;
                for (var user in userList) {
                  if (user.email == signUpEmailCtr.text ||
                      user.username == signUpUsernameCtr.text) {
                    isError = true;
                  }
                }
                if (!isError) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpContScreen(
                              callback: callback,
                              usernameText: signUpUsernameCtr.text,
                              emailText: signUpEmailCtr.text,
                              password: signUpPasswordCtr.text)));
                } else {
                  _showAlertDialog(context, 'Error',
                      'there is also same username or email address.');
                }
              }
            }
          },
          child: Text(
            'Sign Up',
            style: Constants().r16white,
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
