import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/main_screen_components/main_screen_sharing_details_view_model.dart';
import 'package:book_app/widgets/main_screen_components/sharing_details_bottom_buttons.dart';
import 'package:book_app/widgets/main_screen_components/sharing_details_name_category_comment.dart';
import 'package:book_app/widgets/main_screen_components/sharing_details_profile_photo_username.dart';
import 'package:book_app/widgets/main_screen_components/sharing_details_sharing_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class MainScreenSharingDetails extends StatefulWidget {
  Sharing sharing;
  User currentUser;
  Function callback;
  MainScreenSharingDetails({
    required this.sharing,
    required this.currentUser,
    required this.callback,
  });

  @override
  _MainScreenSharingDetailsState createState() =>
      _MainScreenSharingDetailsState();
}

class _MainScreenSharingDetailsState extends State<MainScreenSharingDetails> {
  @override
  void initState() {
    print('initState of ${widget.sharing.bookName}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MainScreenSharingDetailsViewModel>(
      create: (context) => MainScreenSharingDetailsViewModel(),
      builder: (context, _) => Container(
        width: size.width,
        height: size.height * 2 / 3,
        child: StreamBuilder<User>(
          stream: Provider.of<MainScreenSharingDetailsViewModel>(context)
              .getUserInfo(widget.sharing.username),
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
                User? currentSharingUser = asyncSnapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      /// Top Components
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Profile Photo and Username
                          SharingDetailsProfilePhotoUsername(
                            user: currentSharingUser,
                            currentUser: widget.currentUser,
                            callback: widget.callback,
                          ),

                          /// Three point...
                          IconButton(
                            onPressed: () {
                              print('Hello...');
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Middle Components
                    Expanded(
                      child: Row(
                        children: [
                          /// Photo
                          SharingDetailsSharingPhoto(
                            size: size,
                            url: widget.sharing.photoUrl,
                          ),

                          /// Name, Category, and Comment
                          SharingDetailsNameCategoryComment(
                            sharing: widget.sharing,
                          ),
                        ],
                      ),
                    ),

                    /// Bottom Buttons
                    SharingDetailsBottomButtons(
                      sharing: widget.sharing,
                      currentSharingUser: currentSharingUser,
                      currentUser: widget.currentUser,
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
