import 'package:book_app/models/sharing.dart';
import 'package:book_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// firestore'a yeni veri ekleme ve güncelleme hizmeti
  Future<void> setUserData(
      {required String collectionPath,
      required Map<String, dynamic> userAsMap}) async {
    _firestore
        .collection(collectionPath)
        .doc(User.fromMap(userAsMap).username)
        .set(userAsMap);
  }

  Future<void> setSharingData(
      {required String collectionPath,
      required Map<String, dynamic> userAsMap}) async {
    _firestore
        .collection(collectionPath)
        .doc(Sharing.fromMap(userAsMap).idNum)
        .set(userAsMap);
  }

  Future<void> updateSharingInfoFromApi({
    required String collectionPath,
    required String docPath,
    required String mapKey,
    required dynamic mapValue,
  }) {
    return _firestore
        .collection(collectionPath)
        .doc(docPath)
        .update({mapKey: mapValue});
  }

  Stream<QuerySnapshot> getUserListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Stream<DocumentSnapshot> getUserInfoFromApi(
      String referencePath, String username) {
    return _firestore.collection(referencePath).doc(username).snapshots();
  }
}
