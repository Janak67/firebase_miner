import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'firedb_helper.dart';

class FireStorage {
  static FireStorage fireStorage = FireStorage._();

  FireStorage._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProfile(String path) async {
    File file = File(path);
    var ref = firebaseStorage.ref("profile/${file.uri.pathSegments.last}");
    if (FireDbHelper.fireDbHelper.myProfileData.image != null) {}
    try {
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print("File Not Upload - ${e.message}");
    }
    return null;
  }
}
