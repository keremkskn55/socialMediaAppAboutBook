import 'package:book_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SharingDetailsBottomButtonsViewModel with ChangeNotifier {
  Database _database = Database();

  Future<void> updateSharingInfo(
      String sharingId, String keyValue, List favs) async {
    _database.updateSharingInfoFromApi(
        collectionPath: 'sharing',
        docPath: sharingId,
        mapKey: keyValue,
        mapValue: favs);
  }
}
