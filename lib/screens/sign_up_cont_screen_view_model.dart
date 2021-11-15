import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:flutter/material.dart';

class SignUpContScreenViewModel with ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'users';

  Future<void> addNewUser(
    String username,
    String email,
    String password,
    String profilePhotoUrl,
    String name,
    String surname,
    List favoriteBooks,
    List interestedCategories,
  ) async {
    User newUser = User(
      username: username,
      name: name,
      surname: surname,
      email: email,
      password: password,
      profilePhotoUrl: profilePhotoUrl,
      favoriteBooks: favoriteBooks,
      saved: [],
      sharing: [],
      interestedCategories: interestedCategories,
    );

    print('newUser::: ${newUser.toMap()}');

    await _database.setUserData(
        collectionPath: collectionPath, userAsMap: newUser.toMap());
    print('user was added.');
  }
}
