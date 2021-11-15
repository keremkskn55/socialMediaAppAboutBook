import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:flutter/material.dart';

class ProfileScreenViewModel with ChangeNotifier {
  Database _database = Database();

  Future<void> updateProfilePhoto(User user, String photoUrl) async {
    await _database.updateSharingInfoFromApi(
        collectionPath: 'users',
        docPath: user.username,
        mapKey: 'profilePhotoUrl',
        mapValue: photoUrl);
  }
}
