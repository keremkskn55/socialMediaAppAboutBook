import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:flutter/material.dart';

class UpdateFavBookScreenViewModel with ChangeNotifier {
  Database _database = Database();

  Future<void> updateFavBookData(User? user, List tempList) async {
    await _database.updateSharingInfoFromApi(
        collectionPath: 'users',
        docPath: user!.username,
        mapKey: 'favoriteBooks',
        mapValue: tempList);
  }
}
