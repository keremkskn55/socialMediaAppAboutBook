import 'dart:io';

import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_back_and_title.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_book_name.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_categories.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_comment_box.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_sharing_button.dart';
import 'package:book_app/widgets/adding_screen_components/adding_sharing_photo.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddingBookScreen extends StatefulWidget {
  String username;
  User user;
  AddingBookScreen({
    required this.username,
    required this.user,
  });

  @override
  _AddingBookScreenState createState() => _AddingBookScreenState();
}

class _AddingBookScreenState extends State<AddingBookScreen> {
  String? bookNameText;
  File? image;
  TextEditingController bookNameCtr = TextEditingController();

  bool history = false;
  bool science = false;
  bool romantic = false;
  bool adventure = false;
  bool sciFi = false;
  bool novel = false;
  List interestedCategoriesList = [];

  TextEditingController commentCtr = TextEditingController();

  void updateBookName(String tempBookNameText) {
    setState(() {
      bookNameText = tempBookNameText;
    });
    print('bookNameText: $bookNameText');
  }

  void updateImageFile(File? tempImage) {
    setState(() {
      image = tempImage;
    });
    if (image != null) {
      print(image!.path);
    }
  }

  void updateInterestedCategory(bool tempHistory, bool tempScience,
      bool tempRomantic, bool tempAdventure, bool tempSciFi, bool tempNovel) {
    setState(() {
      history = tempHistory;
      science = tempScience;
      romantic = tempRomantic;
      adventure = tempAdventure;
      sciFi = tempSciFi;
      novel = tempNovel;
    });
  }

  void updateCommentCtr(TextEditingController tempCommentCtr) {
    setState(() {
      commentCtr = tempCommentCtr;
    });
    print('commentCtr: ${commentCtr.text}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Spacer(flex: 1),

                /// Back and Title
                AddingBookBackAndTitle(),

                Spacer(flex: 1),

                /// Book Name
                AddingBookBookName(
                  callback: updateBookName,
                  bookNameCtr: bookNameCtr,
                ),

                Spacer(flex: 1),

                /// Photo, Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Sharing Photo
                    AddingSharingPhoto(
                      image: image,
                      callback: updateImageFile,
                    ),

                    /// Categories
                    AddingBookCategories(
                      history: history,
                      science: science,
                      sciFi: sciFi,
                      adventure: adventure,
                      romantic: romantic,
                      novel: novel,
                      callback: updateInterestedCategory,
                    ),
                  ],
                ),

                Spacer(flex: 2),

                /// Comment and Sharing Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// Comment
                    AddingBookCommentBox(
                      commentCtr: commentCtr,
                      callback: updateCommentCtr,
                    ),

                    /// Sharing Button
                    AddingBookSharingButton(
                      username: widget.username,
                      image: image,
                      novel: novel,
                      romantic: romantic,
                      adventure: adventure,
                      sciFi: sciFi,
                      science: science,
                      history: history,
                      bookName: bookNameText,
                      commentText: commentCtr.text,
                      user: widget.user,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
