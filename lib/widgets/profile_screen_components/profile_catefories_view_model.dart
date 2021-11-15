import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:flutter/material.dart';

class ProfileCategoriesViewModel with ChangeNotifier {
  Database _database = Database();

  Future<void> updateInterestedCategories(User? user, List tempList) async {
    await _database.updateSharingInfoFromApi(
        collectionPath: 'users',
        docPath: user!.username,
        mapKey: 'interestedCategories',
        mapValue: tempList);
  }
}
