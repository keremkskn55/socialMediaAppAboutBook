import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/main_screen_components/sharing_details_bottom_buttons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharingDetailsBottomButtons extends StatefulWidget {
  Sharing sharing;
  User? currentSharingUser;
  User currentUser;

  SharingDetailsBottomButtons({
    required this.sharing,
    required this.currentSharingUser,
    required this.currentUser,
  });

  @override
  State<SharingDetailsBottomButtons> createState() =>
      _SharingDetailsBottomButtonsState();
}

class _SharingDetailsBottomButtonsState
    extends State<SharingDetailsBottomButtons> {
  bool isFavMethod() {
    for (var favsPerson in widget.sharing.favs) {
      if (widget.currentUser.username == favsPerson) {
        return true;
      }
    }
    return false;
  }

  bool isSavedMethod() {
    for (var savedPerson in widget.sharing.saved) {
      if (widget.currentUser.username == savedPerson) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SharingDetailsBottomButtonsViewModel>(
      create: (_) => SharingDetailsBottomButtonsViewModel(),
      builder: (context, _) => Row(
        children: [
          /// Fav Button
          IconButton(
            onPressed: () async {
              if (!isFavMethod()) {
                setState(() {
                  widget.sharing.favs.add(widget.currentUser.username);
                });
                await Provider.of<SharingDetailsBottomButtonsViewModel>(context,
                        listen: false)
                    .updateSharingInfo(
                        widget.sharing.idNum, 'favs', widget.sharing.favs);
              } else {
                setState(() {
                  widget.sharing.favs.remove(widget.currentUser.username);
                });
                await Provider.of<SharingDetailsBottomButtonsViewModel>(context,
                        listen: false)
                    .updateSharingInfo(
                        widget.sharing.idNum, 'favs', widget.sharing.favs);
              }
            },
            icon: isFavMethod()
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
          ),

          /// Comment Button
          IconButton(
            onPressed: () {
              print('comment Button');
            },
            icon: Icon(
              Icons.comment,
              color: Colors.white,
            ),
          ),

          /// Saved
          IgnorePointer(
            ignoring: widget.currentUser.username ==
                    widget.currentSharingUser!.username
                ? true
                : false,
            child: Opacity(
              opacity: widget.currentUser.username ==
                      widget.currentSharingUser!.username
                  ? 0
                  : 1,
              child: IconButton(
                onPressed: () async {
                  if (!isSavedMethod()) {
                    setState(() {
                      widget.sharing.saved.add(widget.currentUser.username);
                    });
                    await Provider.of<SharingDetailsBottomButtonsViewModel>(
                            context,
                            listen: false)
                        .updateSharingInfo(widget.sharing.idNum, 'saved',
                            widget.sharing.saved);
                  } else {
                    setState(() {
                      widget.sharing.saved.remove(widget.currentUser.username);
                    });
                    await Provider.of<SharingDetailsBottomButtonsViewModel>(
                            context,
                            listen: false)
                        .updateSharingInfo(widget.sharing.idNum, 'saved',
                            widget.sharing.saved);
                  }
                },
                icon: Icon(
                  Icons.save,
                  color: isSavedMethod() ? Colors.blue : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
