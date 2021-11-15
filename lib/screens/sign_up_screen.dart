import 'package:book_app/models/user.dart';
import 'package:book_app/screens/sign_up_screen_view_model.dart';
import 'package:book_app/widgets/bookia_logo.dart';
import 'package:book_app/widgets/sign_up_screen_components/sign_cont_button.dart';
import 'package:book_app/widgets/sign_up_screen_components/sign_cont_button_fake.dart';
import 'package:book_app/widgets/text_form_field_class.dart';
import 'package:book_app/widgets/sign_up_screen_components/sign_in_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  TextEditingController _signUpUsernameCtr = TextEditingController();
  TextEditingController _signUpEmailCtr = TextEditingController();
  TextEditingController _signUpPasswordCtr = TextEditingController();
  TextEditingController _signUpPasswordAgainCtr = TextEditingController();

  void navigatorPopFunc() {
    Navigator.pop(context);
  }

  void controllerUpdate(TextEditingController tempCtr, String hintTextInfo) {
    if (hintTextInfo == 'E-mail') {
      _signUpEmailCtr = tempCtr;
    } else if (hintTextInfo == 'username') {
      _signUpUsernameCtr = tempCtr;
    } else if (hintTextInfo == 'Password') {
      _signUpPasswordCtr = tempCtr;
    } else if (hintTextInfo == 'Password Again') {
      _signUpPasswordAgainCtr = tempCtr;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SignUpScreenViewModel>(
      create: (_) => SignUpScreenViewModel(),
      builder: (context, _) => Scaffold(
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
            key: _signUpKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Spacer(flex: 2),

                    /// Logo
                    BookiaLogo(
                      size: size,
                    ),

                    Spacer(flex: 1),

                    /// Sign Up Text
                    Text(
                      'Sign Up',
                      style: Constants().r36white,
                    ),

                    Spacer(flex: 1),

                    /// username text field
                    TextFormFieldClass(
                      signCtr: _signUpUsernameCtr,
                      hintTextInfo: 'username',
                      signKey: _signUpKey,
                      callback: controllerUpdate,
                    ),

                    SizedBox(height: 10),

                    /// Email text field
                    TextFormFieldClass(
                      signCtr: _signUpEmailCtr,
                      hintTextInfo: 'E-mail',
                      signKey: _signUpKey,
                      callback: controllerUpdate,
                    ),

                    SizedBox(height: 10),

                    /// Password text field
                    TextFormFieldClass(
                      signCtr: _signUpPasswordCtr,
                      hintTextInfo: 'Password',
                      signKey: _signUpKey,
                      callback: controllerUpdate,
                    ),

                    SizedBox(height: 10),

                    /// Password Again text field
                    TextFormFieldClass(
                      signCtr: _signUpPasswordAgainCtr,
                      hintTextInfo: 'Password Again',
                      signKey: _signUpKey,
                      callback: controllerUpdate,
                    ),

                    SizedBox(height: 10),

                    StreamBuilder<List<User>>(
                      stream: Provider.of<SignUpScreenViewModel>(context,
                              listen: false)
                          .getUserList(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.hasError) {
                          return SignContButtonFake();
                        } else {
                          if (!asyncSnapshot.hasData) {
                            return SignContButtonFake();
                          } else {
                            List<User> userList = asyncSnapshot.data!;
                            return SignUpContButton(
                              signUpKey: _signUpKey,
                              signUpEmailCtr: _signUpEmailCtr,
                              signUpUsernameCtr: _signUpUsernameCtr,
                              signUpPasswordCtr: _signUpPasswordCtr,
                              signUpPasswordAgainCtr: _signUpPasswordAgainCtr,
                              callback: navigatorPopFunc,
                              userList: userList,
                            );
                          }
                        }
                      },
                    ),

                    /// Sign Up Button
                    // SignUpContButton(
                    //   signUpKey: _signUpKey,
                    //   signUpEmailCtr: _signUpEmailCtr,
                    //   signUpUsernameCtr: _signUpUsernameCtr,
                    //   signUpPasswordCtr: _signUpPasswordCtr,
                    //   signUpPasswordAgainCtr: _signUpPasswordAgainCtr,
                    //   callback: navigatorPopFunc,
                    // ),

                    Spacer(),

                    /// Sign In Button
                    SignInBackButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
