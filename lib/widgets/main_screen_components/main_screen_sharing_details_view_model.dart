import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:flutter/material.dart';

class MainScreenSharingDetailsViewModel with ChangeNotifier {
  Database _database = Database();

  Stream<User> getUserInfo(String username) {
    return _database
        .getUserInfoFromApi('users', username)
        .map((docSnap) => User.fromMap(docSnap.data() as Map));
  }
}
