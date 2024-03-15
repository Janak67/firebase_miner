import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/chat/model/chat_model.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';

class FireDbHelper {
  static FireDbHelper fireDbHelper = FireDbHelper._();

  FireDbHelper._();

  ProfileModel myProfileData = ProfileModel();
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

  Future<void> myProfile() async {
    DocumentSnapshot ds = await firebaseFirestore
        .collection("User")
        .doc(FireHelper.fireHelper.user!.uid)
        .get();
    Map? data = ds.data() as Map?;
    if (data != null) {
      myProfileData = ProfileModel(
        uid: data['uid'],
        name: data['name'],
        address: data['address'],
        mobile: data['mobile'],
        email: data['email'],
        bio: data['bio'],
        image: data['image'],
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllContact() {
    return firebaseFirestore
        .collection("User")
        .where("uid", isNotEqualTo: FireHelper.fireHelper.user!.uid)
        .snapshots();
  }

  Future<void> sendMessage(
      ChatModel? model, ProfileModel? myProfile, ProfileModel? fProfile) async {
    String myUID = FireHelper.fireHelper.user!.uid;
    await firebaseFirestore
        .collection("Chat")
        .doc(
            fProfile!.docId != null ? fProfile.docId : '$myUID-${fProfile.uid}')
        .collection('message')
        .add({
      "id": model!.id,
      "msg": model.msg,
      "name": model.name,
      "date": model.date,
      "time": model.time,
      "timestamp": Timestamp.now()
    });
    await firebaseFirestore
        .collection("Chat")
        .doc(fProfile.docId ?? '$myUID-${fProfile.uid}')
        .set({
      'data1': [
        myProfile!.name,
        myProfile.uid,
        myProfile.image,
        myProfile.mobile
      ],
      'data2': [fProfile.name, fProfile.uid, fProfile.image, fProfile.mobile],
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatContact() {
    return firebaseFirestore.collection("Chat").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChat(String docID) {
    return firebaseFirestore
        .collection("Chat")
        .doc(docID)
        .collection("message")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> deleteMessage(String docID, String msgID) async {
    await firebaseFirestore
        .collection("Chat")
        .doc(docID)
        .collection("message")
        .doc(msgID)
        .delete();
  }
}
