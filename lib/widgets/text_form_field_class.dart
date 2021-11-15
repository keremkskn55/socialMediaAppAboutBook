import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TextFormFieldClass extends StatelessWidget {
  final TextEditingController signCtr;
  String hintTextInfo;
  GlobalKey<FormState> signKey;
  Function callback;

  TextFormFieldClass({
    required this.signCtr,
    required this.hintTextInfo,
    required this.signKey,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width - 36,
      child: TextFormField(
        controller: signCtr,
        obscureText:
            (hintTextInfo == 'Password' || hintTextInfo == 'Password Again')
                ? true
                : false,
        validator: (_val) {
          if (_val!.isEmpty) {
            return 'Please fill the field';
          } else if ('username' == hintTextInfo) {
            if (_val.length < 6) {
              return 'Enter at least 6 character';
            }
          } else if ('E-mail' == hintTextInfo) {
            if (!EmailValidator.validate(_val)) {
              return 'Please enter valid mail address';
            }
          } else {
            if (_val.length < 6) {
              return 'Please enter long password';
            }
          }
          return null;
        },
        onChanged: (_) {
          callback(signCtr, hintTextInfo);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            hintTextInfo == 'E-mail'
                ? Icons.email
                : hintTextInfo == 'username'
                    ? Icons.person
                    : Icons.lock,
            color: Colors.black,
          ),
          hintText: hintTextInfo,
          hintStyle: Constants().r16black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
        ),
      ),
    );
  }
}
