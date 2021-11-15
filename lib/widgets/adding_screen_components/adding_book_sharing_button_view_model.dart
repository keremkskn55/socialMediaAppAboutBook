import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:book_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddingBookSharingButtonViewModel with ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'sharing';

  Future<void> addSharingUser(
    String idNum,
    String username,
    String bookName,
    String photoUrl,
    String mainComment,
    List categories,
  ) async {
    Sharing newSharing = Sharing(
      idNum: idNum,
      username: username,
      categories: categories,
      bookName: bookName,
      photoUrl: photoUrl,
      mainComments: mainComment,
      favs: [],
      comments: [],
      saved: [],
      sharingTime: DateFormat('yyyy.MM.dd HH:mm SSS').format(DateTime.now()),
    );

    print('newUser::: ${newSharing.toMap()}');

    await _database.setSharingData(
        collectionPath: collectionPath, userAsMap: newSharing.toMap());
    print('sharing was added.');
  }

  Future<void> updateUserSharingInfo(User user, String idNum) async {
    List tempSharingList = []..addAll(user.sharing);
    tempSharingList.add(idNum);
    print(tempSharingList);
    await _database.updateSharingInfoFromApi(
        collectionPath: 'users',
        docPath: user.username,
        mapKey: 'sharing',
        mapValue: tempSharingList);
  }
}
