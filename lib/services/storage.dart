import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String username) async {
    File file = File(filePath);

    await firebase_storage.FirebaseStorage.instance
        .ref('$username/profile_photo.png')
        .putFile(file);
    print('uploadFile inside');
  }

  Future<void> uploadFileForSharing(String filePath, String idNum) async {
    File file = File(filePath);

    await firebase_storage.FirebaseStorage.instance
        .ref('$idNum/sharing_photo.png')
        .putFile(file);
    print('uploadFile inside');
  }

  Future<String> takeLinkPhoto(String username) async {
    firebase_storage.Reference ref = storage.ref('$username/profile_photo.png');

    String refPath = await ref.getDownloadURL();

    print('ref: $refPath');
    return refPath;
  }

  Future<String> takeLinkPhotoForSharing(String idNum) async {
    firebase_storage.Reference ref = storage.ref('$idNum/sharing_photo.png');

    String refPath = await ref.getDownloadURL();

    print('ref: $refPath');
    return refPath;
  }
}
