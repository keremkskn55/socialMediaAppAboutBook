import 'package:book_app/models/user.dart';
import 'package:book_app/screens/update_fav_book_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfileFavBook extends StatelessWidget {
  User? user;
  bool isSameUser;
  Function callback;

  ProfileFavBook({
    required this.user,
    required this.isSameUser,
    required this.callback,
  });

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
                  'Favorite Books',
                  style: Constants().r16white,
                ),
                Spacer(),
                IgnorePointer(
                  ignoring: !isSameUser,
                  child: Opacity(
                    opacity: isSameUser ? 1 : 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateFavBookScreen(
                                      profileUser: user,
                                      callback: callback,
                                    )));
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
                itemCount: user!.favoriteBooks.length,
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
                        '${user!.favoriteBooks[index]}',
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
