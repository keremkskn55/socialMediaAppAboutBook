import 'package:flutter/material.dart';

class AddingBookCommentBox extends StatelessWidget {
  TextEditingController commentCtr;
  Function callback;
  AddingBookCommentBox({required this.commentCtr, required this.callback});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 2 / 3,
      child: TextField(
        controller: commentCtr,
        maxLines: 2,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'Enter your Comment',
          filled: true,
          fillColor: Colors.white.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
            ),
          ),
        ),
        onChanged: (_val) {
          print('comment was changed');
          callback(commentCtr);
        },
      ),
    );
  }
}
