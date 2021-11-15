import 'dart:io';

import 'package:book_app/models/user.dart';
import 'package:book_app/screens/profile_screen_view_model.dart';
import 'package:book_app/services/storage.dart';
import 'package:book_app/widgets/main_screen_components/sharing_in_main_screen.dart';
import 'package:book_app/widgets/profile_screen_components/profile_categories.dart';
import 'package:book_app/widgets/profile_screen_components/profile_fav_book.dart';
import 'package:book_app/widgets/profile_screen_components/profile_screen_sharings.dart';
import 'package:book_app/widgets/profile_screen_components/profile_sharing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  User? profileUser;
  User currentUser;
  bool isSameUser;

  ProfileScreen({
    required this.profileUser,
    required this.isSameUser,
    required this.currentUser,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File newImage;
  late String photoUrl;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        newImage = imageTemporary;
        print('image: $newImage');
      });

      await Storage().uploadFile(image.path, widget.profileUser!.username);
      photoUrl = await Storage().takeLinkPhoto(widget.profileUser!.username);
      setState(() {});
      await ProfileScreenViewModel()
          .updateProfilePhoto(widget.currentUser, photoUrl);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void buildSetState() {
    setState(() {});
  }

  @override
  void initState() {
    photoUrl = widget.profileUser!.profilePhotoUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: topComponentsOfProfileScreen(size),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              expandedHeight: size.width / 2 + 260,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            buildSharing(currentUser: widget.currentUser),
          ],
        ),
      ),
    );
  }

  Column topComponentsOfProfileScreen(Size size) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: size.width / 4,
            ),
            Container(
              width: size.width / 2 - 8,
              height: size.width / 2 - 8,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 4 - 4)),
                image: DecorationImage(
                    image: NetworkImage(
                      photoUrl,
                      // widget.profileUser!.profilePhotoUrl,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                ignoring:
                    widget.currentUser.username == widget.profileUser!.username
                        ? false
                        : true,
                child: Opacity(
                  opacity: widget.currentUser.username ==
                          widget.profileUser!.username
                      ? 1
                      : 0,
                  child: InkWell(
                    onTap: () {
                      print('helloHello');
                      chooseGalleryOrCamera();
                    },
                    child: Container(
                      width: size.width / 8,
                      height: size.width / 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(size.width / 16),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.change_circle_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            '${widget.profileUser!.name} ${widget.profileUser!.surname}',
            style: Constants().r20white,
          ),
        ),
        ProfileFavBook(
          user: widget.profileUser,
          isSameUser: widget.isSameUser,
          callback: buildSetState,
        ),
        ProfileCategories(
          user: widget.profileUser,
          isSameUser: widget.isSameUser,
        ),
        // ProfileSharing(
        //   user: widget.profileUser,
        //   isSameUser: widget.isSameUser,
        // ),
      ],
    );
  }

  Widget buildSharing({required User currentUser}) => SliverToBoxAdapter(
        child: SharingInMainScreen(
          mainUser: currentUser,
          callback: buildSetState,
          isMainScreen: false,
          profileUser: widget.profileUser,
        ),
      );

  void chooseGalleryOrCamera() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Gallery',
                              style: Constants().r16black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Camera',
                              style: Constants().r16black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
