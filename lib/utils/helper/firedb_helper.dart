import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';

class FireDbHelper {
  static FireDbHelper fireDbHelper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addProfile(ProfileModel pm) async {
    await firebaseFirestore
        .collection("User")
        .doc(FireHelper.fireHelper.user!.uid)
        .set({
      "uid": pm.uid,
      "name": pm.name,
      "bio": pm.bio,
      "mobile": pm.mobile,
      "email": pm.email,
      "address": pm.address,
      "image": pm.image,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileData() {
    return firebaseFirestore
        .collection("User")
        .doc(FireHelper.fireHelper.user!.uid)
        .snapshots();
  }
}
