import 'package:book_app/models/user.dart';
import 'package:book_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel with ChangeNotifier {
  String _collectionPath = 'users';
  Database _database = Database();

  Stream<List<User>> getUserList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getUserListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<User>> streamListUser = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => User.fromMap(docSnap.data() as Map))
            .toList());

    return streamListUser;
  }
}
