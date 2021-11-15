import 'package:book_app/constants.dart';
import 'package:book_app/widgets/bookia_logo.dart';
import 'package:book_app/widgets/sign_in_screen_components/sign_in_buttons.dart';
import 'package:book_app/widgets/sign_in_screen_components/sign_up_button.dart';
import 'package:book_app/widgets/sign_in_screen_components/social_media_buttons.dart';
import 'package:book_app/widgets/text_form_field_class.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();

  TextEditingController _signInEmailCtr = TextEditingController();
  TextEditingController _signInPasswordCtr = TextEditingController();

  void controllerUpdate(TextEditingController tempCtr, String hintTextInfo) {
    if (hintTextInfo == 'E-mail') {
      _signInEmailCtr = tempCtr;
    } else if (hintTextInfo == 'Password') {
      _signInPasswordCtr = tempCtr;
    }
  }

  void _showDialog(String detail) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(detail),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Form(
          key: _signInKey,
          child: Column(
            children: [
              Spacer(flex: 2),
              BookiaLogo(size: size),
              Spacer(flex: 1),
              Text(
                'Sign In',
                style: Constants().r36white,
              ),
              Spacer(flex: 1),
              TextFormFieldClass(
                signCtr: _signInEmailCtr,
                hintTextInfo: 'E-mail',
                signKey: _signInKey,
                callback: controllerUpdate,
              ),
              SizedBox(height: 10),
              TextFormFieldClass(
                signCtr: _signInPasswordCtr,
                hintTextInfo: 'Password',
                signKey: _signInKey,
                callback: controllerUpdate,
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ForgotPassword(),
                    SignInButton(
                      email: _signInEmailCtr.text,
                      password: _signInPasswordCtr.text,
                      signInKey: _signInKey,
                      callback: _showDialog,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Text(
                'or',
                style: Constants().r20white,
              ),
              Spacer(flex: 1),
              GoogleButton(),
              SizedBox(
                height: 10,
              ),
              AppleButton(),
              Spacer(flex: 1),
              SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
