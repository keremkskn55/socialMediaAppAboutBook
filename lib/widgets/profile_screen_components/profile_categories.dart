import 'package:book_app/models/user.dart';
import 'package:book_app/widgets/profile_screen_components/profile_catefories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ProfileCategories extends StatefulWidget {
  User? user;
  bool isSameUser;

  ProfileCategories({
    required this.user,
    required this.isSameUser,
  });

  @override
  State<ProfileCategories> createState() => _ProfileCategoriesState();
}

class _ProfileCategoriesState extends State<ProfileCategories> {
  bool history = false;
  bool science = false;
  bool adventure = false;
  bool novel = false;
  bool sciFi = false;
  bool romantic = false;

  void updateFavBook(BuildContext context, Size size) {
    for (var category in widget.user!.interestedCategories) {
      if (category == 'history') {
        history = true;
      }
      if (category == 'science') {
        science = true;
      }
      if (category == 'adventure') {
        adventure = true;
      }
      if (category == 'sciFi') {
        sciFi = true;
      }
      if (category == 'novel') {
        novel = true;
      }
      if (category == 'romantic') {
        romantic = true;
      }
    }

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          print('bottomCategory Model');
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(24),
              height: size.height / 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Constants().blackBlue,
                    Constants().blue,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Wrap(
                children: [
                  buildCategoryChoosingButton('Science', setState),
                  buildCategoryChoosingButton('History', setState),
                  buildCategoryChoosingButton('Sci Fi', setState),
                  buildCategoryChoosingButton('Romantic', setState),
                  buildCategoryChoosingButton('Novel', setState),
                  buildCategoryChoosingButton('Adventure', setState),
                ],
              ),
            );
          });
        });
  }

  Widget buildCategoryChoosingButton(
      String category, StateSetter tempSetState) {
    bool isSelected = false;

    if (category == 'History') {
      isSelected = history;
    }
    if (category == 'Science') {
      isSelected = science;
    }
    if (category == 'Sci Fi') {
      isSelected = sciFi;
    }
    if (category == 'Novel') {
      isSelected = novel;
    }
    if (category == 'Romantic') {
      isSelected = romantic;
    }
    if (category == 'Adventure') {
      isSelected = adventure;
    }

    return ChangeNotifierProvider<ProfileCategoriesViewModel>(
      create: (context) => ProfileCategoriesViewModel(),
      builder: (context, _) => InkWell(
        onTap: () async {
          tempSetState(() {
            setState(() {
              if (category == 'History') {
                history = !history;
                isSelected = !isSelected;
                if (history) {
                  widget.user!.interestedCategories.add('history');
                } else {
                  widget.user!.interestedCategories.remove('history');
                }
              }
              if (category == 'Science') {
                science = !science;
                isSelected = !isSelected;
                if (science) {
                  widget.user!.interestedCategories.add('science');
                } else {
                  widget.user!.interestedCategories.remove('science');
                }
              }
              if (category == 'Sci Fi') {
                sciFi = !sciFi;
                isSelected = !isSelected;
                if (sciFi) {
                  widget.user!.interestedCategories.add('sciFi');
                } else {
                  widget.user!.interestedCategories.remove('sciFi');
                }
              }
              if (category == 'Novel') {
                novel = !novel;
                isSelected = !isSelected;
                if (novel) {
                  widget.user!.interestedCategories.add('novel');
                } else {
                  widget.user!.interestedCategories.remove('novel');
                }
              }
              if (category == 'Romantic') {
                romantic = !romantic;
                isSelected = !isSelected;
                if (romantic) {
                  widget.user!.interestedCategories.add('romantic');
                } else {
                  widget.user!.interestedCategories.remove('romantic');
                }
              }
              if (category == 'Adventure') {
                adventure = !adventure;
                isSelected = !isSelected;
                if (adventure) {
                  widget.user!.interestedCategories.add('adventure');
                } else {
                  widget.user!.interestedCategories.remove('adventure');
                }
              }
            });
          });
          print(widget.user!.interestedCategories);
          await Provider.of<ProfileCategoriesViewModel>(context, listen: false)
              .updateInterestedCategories(
                  widget.user, widget.user!.interestedCategories);
        },
        child: Container(
          margin: EdgeInsets.all(8),
          width: 100,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? Color(0xFF3A6073)
                : Color(0xFF3A6073).withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              category,
              style: Constants().r16white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            /// Title and Edit buttons
            Row(
              children: [
                Text(
                  'Interested Categories',
                  style: Constants().r16white,
                ),
                Spacer(),
                IgnorePointer(
                  ignoring: !widget.isSameUser,
                  child: Opacity(
                    opacity: widget.isSameUser ? 1 : 0,
                    child: IconButton(
                      onPressed: () {
                        updateFavBook(context, size);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Divider
            Divider(
              height: 10,
              color: Colors.white,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: widget.user!.interestedCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF3A6073),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.user!.interestedCategories[index]}',
                        style: Constants().r16white,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Divider
            Divider(
              height: 10,
              color: Colors.white,
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }
}
