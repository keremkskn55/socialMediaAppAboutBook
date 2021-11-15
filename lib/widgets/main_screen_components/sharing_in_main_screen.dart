import 'package:book_app/constants.dart';
import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/main_screen_components/sharing_in_main_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen_sharing_details.dart';

class SharingInMainScreen extends StatefulWidget {
  User mainUser;
  User? profileUser;
  Function callback;
  bool isMainScreen;
  SharingInMainScreen({
    required this.mainUser,
    required this.callback,
    required this.isMainScreen,
    this.profileUser,
  });

  @override
  State<SharingInMainScreen> createState() => _SharingInMainScreenState();
}

class _SharingInMainScreenState extends State<SharingInMainScreen> {
  @override
  Widget build(BuildContext context) {
    print('I am in _SharingInMainScreenState');
    return ChangeNotifierProvider<SharingInMainScreenViewModel>(
      create: (context) => SharingInMainScreenViewModel(),
      builder: (context, _) => StreamBuilder<List<Sharing>>(
        stream:
            Provider.of<SharingInMainScreenViewModel>(context, listen: false)
                .getSharingList(),
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
              List<Sharing>? sharingList = asyncSnapshot.data;
              return BuildListView(
                sharingList: sharingList,
                interestedCategoryList: widget.mainUser.interestedCategories,
                currentUser: widget.mainUser,
                callback: widget.callback,
                isMainScreen: widget.isMainScreen,
                profileUser: widget.profileUser,
              );
            }
          }
        },
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  List<Sharing>? sharingList;
  List interestedCategoryList;
  User currentUser;
  User? profileUser;
  bool isMainScreen;
  Function callback;
  BuildListView({
    required this.sharingList,
    required this.interestedCategoryList,
    required this.currentUser,
    required this.callback,
    required this.isMainScreen,
    this.profileUser,
  });

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  List<Sharing> currentSharing = [];

  void setListCurrentSharing() {
    int counter = 0;

    if (widget.sharingList!.isNotEmpty) {
      currentSharing.clear();
      if (widget.isMainScreen) {
        for (var categoryInUser in widget.interestedCategoryList) {
          print('InitState\'s categoryUser: $categoryInUser');
          for (var sharing in widget.sharingList!) {
            print('InitState\'s sharing: ${sharing.categories}');
            for (var categoryInSharing in sharing.categories) {
              print('InitState\'s categoryInSharing: $categoryInSharing');
              if (categoryInSharing == categoryInUser) {
                if (currentSharing.isEmpty) {
                  currentSharing.add(sharing);
                } else {
                  for (var currentSharingElement in currentSharing) {
                    if (currentSharingElement.bookName == sharing.bookName) {
                      counter++;
                    }
                  }
                  if (counter == 0) {
                    currentSharing.add(sharing);
                  }
                }
              }
              counter = 0;
            }
          }
        }
      } else {
        print('profile User Info');
        print('${widget.profileUser!.username}');

        for (var sharing in widget.sharingList!) {
          for (var sharingProfileUserId in widget.profileUser!.sharing) {
            if (sharing.idNum == sharingProfileUserId) {
              currentSharing.add(sharing);
            }
          }
          for (var sharingSavedUser in sharing.saved) {
            if (sharingSavedUser == widget.profileUser!.username) {
              currentSharing.add(sharing);
            }
          }
        }

        for (var savingProfileUser in widget.profileUser!.saved) {
          currentSharing.add(savingProfileUser);
        }
      }

      for (var element in currentSharing) {
        print('element:::  ${element.bookName}');
      }
    }
    currentSharing.sort((a, b) => (b.sharingTime).compareTo(a.sharingTime));
  }

  @override
  void initState() {
    print('Hello Init State');
    setListCurrentSharing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: currentSharing.length,
        itemBuilder: (context, index) {
          return MainScreenSharingDetails(
            sharing: currentSharing[index],
            currentUser: widget.currentUser,
            callback: widget.callback,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
