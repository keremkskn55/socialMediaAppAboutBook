import 'package:book_app/models/sharing.dart';
import 'package:book_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SharingInMainScreenViewModel with ChangeNotifier {
  String _collectionPath = 'sharing';
  Database _database = Database();

  Stream<List<Sharing>> getSharingList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getUserListFromApi(_collectionPath)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Sharing>> streamListBook = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => Sharing.fromMap(docSnap.data() as Map))
            .toList());

    return streamListBook;
  }
}
