import 'dart:io';

import 'package:book_app/models/user.dart';
import 'package:book_app/services/storage.dart';
import 'package:book_app/widgets/adding_screen_components/adding_book_sharing_button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddingBookSharingButton extends StatefulWidget {
  String username;
  String? bookName;
  File? image;
  bool history;
  bool science;
  bool romantic;
  bool adventure;
  bool sciFi;
  bool novel;
  String commentText;
  User user;

  AddingBookSharingButton({
    required this.username,
    required this.bookName,
    required this.image,
    required this.history,
    required this.science,
    required this.romantic,
    required this.adventure,
    required this.sciFi,
    required this.novel,
    required this.commentText,
    required this.user,
  });

  @override
  State<AddingBookSharingButton> createState() =>
      _AddingBookSharingButtonState();
}

class _AddingBookSharingButtonState extends State<AddingBookSharingButton> {
  String idNum = Uuid().v1();
  late String photoUrl;
  List categoriesOfBook = [];

  setCategoriesBook() {
    categoriesOfBook.clear();
    if (widget.history) {
      categoriesOfBook.add('history');
    }
    if (widget.science) {
      categoriesOfBook.add('science');
    }
    if (widget.romantic) {
      categoriesOfBook.add('romantic');
    }
    if (widget.adventure) {
      categoriesOfBook.add('adventure');
    }
    if (widget.sciFi) {
      categoriesOfBook.add('sciFi');
    }
    if (widget.novel) {
      categoriesOfBook.add('novel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AddingBookSharingButtonViewModel(),
        builder: (context, _) {
          return InkWell(
            onTap: () async {
              if (widget.bookName == null || widget.bookName == '') {
                _showDialog(context, 'Please enter a book name.');
              } else if (widget.image == null) {
                _showDialog(context, 'Please add a photo.');
              } else if (!widget.history &&
                  !widget.science &&
                  !widget.romantic &&
                  !widget.adventure &&
                  !widget.sciFi &&
                  !widget.novel) {
                _showDialog(context, 'Please choose at least one category.');
              } else {
                String newBookName = widget.bookName!;
                setCategoriesBook();
                print(widget.username);
                print(widget.bookName);
                print(widget.image!.path);
                print(categoriesOfBook);
                print(widget.commentText);

                await Provider.of<Storage>(context, listen: false)
                    .uploadFileForSharing(widget.image!.path, idNum);

                photoUrl = await Provider.of<Storage>(context, listen: false)
                    .takeLinkPhotoForSharing(idNum);

                await Provider.of<AddingBookSharingButtonViewModel>(context,
                        listen: false)
                    .addSharingUser(
                  idNum,
                  widget.username,
                  newBookName,
                  photoUrl,
                  widget.commentText,
                  categoriesOfBook,
                );

                await Provider.of<AddingBookSharingButtonViewModel>(context,
                        listen: false)
                    .updateUserSharingInfo(widget.user, idNum);
                Navigator.pop(context, true);
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(Icons.transit_enterexit),
                ),
              ),
            ),
          );
        });
  }

  void _showDialog(BuildContext context, String detail) {
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
}
