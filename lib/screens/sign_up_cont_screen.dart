import 'dart:io';

import 'package:book_app/models/user.dart';
import 'package:book_app/screens/sign_up_cont_screen_view_model.dart';
import 'package:book_app/services/auth.dart';
import 'package:book_app/services/storage.dart';
import 'package:book_app/widgets/sign_up_cont_screen_components/favorite_book_sign_up.dart';
import 'package:book_app/widgets/sign_up_cont_screen_components/interested_category_sign_up.dart';
import 'package:book_app/widgets/sign_up_cont_screen_components/profile_name_surname.dart';
import 'package:book_app/widgets/sign_up_cont_screen_components/sign_up_cont_screen_top_comp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SignUpContScreen extends StatefulWidget {
  String usernameText;
  String emailText;
  String password;
  Function callback;
  SignUpContScreen({
    required this.usernameText,
    required this.emailText,
    required this.password,
    required this.callback,
  });

  @override
  _SignUpContScreenState createState() => _SignUpContScreenState();
}

class _SignUpContScreenState extends State<SignUpContScreen> {
  GlobalKey<FormState> nameSurnameKey = GlobalKey<FormState>();

  String photoUrl =
      'https://firebasestorage.googleapis.com/v0/b/book-app-326817.appspot.com/o/undefined_profile_photo.jpg?alt=media&token=3542822f-f394-4dd2-89c0-a068b0b041a8';

  File? image;

  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();

  bool history = false;
  bool science = false;
  bool romantic = false;
  bool adventure = false;
  bool sciFi = false;
  bool novel = false;
  List interestedCategoriesList = [];

  List favBookList = [];

  void updateTextFields(TextEditingController tempNameCtr,
      TextEditingController tempSurnameCtr, File? tempImage) {
    setState(() {
      nameCtr = tempNameCtr;
      surnameCtr = tempSurnameCtr;
      image = tempImage;
    });
    print(nameCtr.text);
    print(surnameCtr.text);
  }

  void updateFavBookList(List tempList) {
    setState(() {
      favBookList = []..addAll(tempList);
    });
    print(favBookList);
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

  void setInterestedCategories() {
    interestedCategoriesList.clear();
    if (history) {
      interestedCategoriesList.add('history');
    }
    if (science) {
      interestedCategoriesList.add('science');
    }
    if (romantic) {
      interestedCategoriesList.add('romantic');
    }
    if (sciFi) {
      interestedCategoriesList.add('sciFi');
    }
    if (adventure) {
      interestedCategoriesList.add('adventure');
    }
    if (novel) {
      interestedCategoriesList.add('novel');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => SignUpContScreenViewModel(),
      builder: (context, _) => Scaffold(
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
          child: Column(
            children: [
              Spacer(flex: 1),

              /// Top Components
              SignUpcContScreenTopComp(),

              Spacer(flex: 1),

              /// Profile Photo, Name, Surname,
              ProfileNameSurname(
                callback: updateTextFields,
                photoUrl: photoUrl,
                image: image,
                nameSurnameKey: nameSurnameKey,
                nameCtr: nameCtr,
                surnameCtr: surnameCtr,
              ),

              /// Divider
              SizedBox(
                width: size.width - 16,
                child: Divider(
                  height: 20,
                  color: Colors.white,
                ),
              ),

              /// Favorite Book
              FavoriteBookSignUp(callback: updateFavBookList),

              /// Interested Category
              InterestedCategorySignUp(
                history: history,
                science: science,
                sciFi: sciFi,
                adventure: adventure,
                romantic: romantic,
                novel: novel,
                callback: updateInterestedCategory,
              ),

              Spacer(flex: 2),

              /// Divider
              SizedBox(
                width: size.width - 16,
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),

              /// Create Button
              InkWell(
                onTap: () async {
                  print('Creating Account...');
                  print('username:: ${widget.usernameText}');
                  print('email:: ${widget.emailText}');
                  print('password:: ${widget.password}');
                  print('photoUrl:: $photoUrl');
                  print('imege:: $image');
                  print('name:: ${nameCtr.text}');
                  print('surname:: ${surnameCtr.text}');
                  print('favBook:: $favBookList');
                  print('-------------');
                  print('history:: $history');
                  print('science:: $science');
                  print('romantic:: $romantic');

                  await Provider.of<Storage>(context, listen: false)
                      .uploadFile(image!.path, widget.usernameText);

                  print('change After photo');

                  if (image != null) {
                    photoUrl =
                        await Provider.of<Storage>(context, listen: false)
                            .takeLinkPhoto(widget.usernameText);
                    setInterestedCategories();
                  }

                  await Provider.of<SignUpContScreenViewModel>(context,
                          listen: false)
                      .addNewUser(
                          widget.usernameText,
                          widget.emailText,
                          widget.password,
                          photoUrl,
                          nameCtr.text,
                          surnameCtr.text,
                          favBookList,
                          interestedCategoriesList);

                  await Provider.of<Auth>(context, listen: false)
                      .createUserWithEmail(widget.emailText, widget.password,
                          widget.usernameText);

                  Navigator.pop(context);
                  widget.callback();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  width: size.width * 2 / 3,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFF44CA62).withOpacity(0.75),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: Constants().r20white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
