import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/controller/profile_controller.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  ProfileController controller = Get.put(ProfileController());
  String? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              DocumentSnapshot? ds = snapshot.data;
              Map? data = ds?.data() as Map?;
              if (data != null) {
                txtName.text = data['name'];
                txtEmail.text = data['email'];
                txtBio.text = data['bio'];
                txtAddress.text = data['address'];
                txtMobile.text = data['mobile'];
                image = data['image'];
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomTextField(label: 'Name', controller: txtName),
                      CustomTextField(label: 'Mobile', controller: txtMobile),
                      CustomTextField(label: 'Email', controller: txtEmail),
                      CustomTextField(label: 'Bio', controller: txtBio),
                      CustomTextField(label: 'Address', controller: txtAddress),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          String? path;
                          if (controller.path.value != null) {}
                          ProfileModel p1 = ProfileModel(
                            uid: FireHelper.fireHelper.user!.uid,
                            name: txtName.text,
                            mobile: txtMobile.text,
                            bio: txtBio.text,
                            email: txtEmail.text,
                            address: txtAddress.text,
                            image: controller.path.value != null ? path : image,
                          );
                          FireDbHelper.fireDbHelper.addProfile(p1);
                          Get.offAllNamed('dash');
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
