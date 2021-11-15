import 'package:book_app/constants.dart';
import 'package:book_app/models/sharing.dart';
import 'package:flutter/material.dart';

class SharingDetailsNameCategoryComment extends StatelessWidget {
  Sharing sharing;

  SharingDetailsNameCategoryComment({required this.sharing});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Color(0xFFC4C4C4).withOpacity(0.25),
              ),
              child: Center(
                child: Text(
                  '${sharing.bookName}',
                  style: Constants().r16white,
                ),
              ),
            ),
            SizedBox(
              width: size.width / 2,
              height: 54,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sharing.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Color(0xFFC4C4C4).withOpacity(0.25),
                    ),
                    child: Center(
                      child: Text(
                        sharing.categories[index],
                        style: Constants().r16white,
                      ),
                    ),
                  );
                },
              ),
            ),
            Wrap(
              children: [
                Text(
                  sharing.mainComments,
                  style: Constants().r16white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
