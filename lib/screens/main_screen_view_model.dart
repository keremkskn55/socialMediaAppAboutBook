import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreenViewModel with ChangeNotifier {
  String _collectionPath = 'users';
  Database _database = Database();

  Stream<DocumentSnapshot> getUserInfo(String username) {
    return _database.getUserInfoFromApi(_collectionPath, username);
  }
}
