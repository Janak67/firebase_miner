import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/controller/profile_controller.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/helper/storage.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:firebase_miner/utils/widget/image_bottom_sheet.dart';
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
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          centerTitle: true,
          title: Text('Profile', style: txtWhite),
        ),
        body: Stack(
          children: [
            Obx(
              () => settingController.isLight.value == false
                  ? Image.asset(
                      'assets/img/bgDark.jpg',
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.5),
                    )
                  : Image.asset(
                      'assets/img/bgLight.jpg',
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    ),
            ),
            StreamBuilder(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Center(
                              child: InkWell(
                                onTap: () {
                                  showBottom(context);
                                },
                                child: controller.path.value == null &&
                                        image == null
                                    ? const CircleAvatar(
                                        radius: 60,
                                        child: Icon(Icons.add_a_photo_outlined,
                                            size: 40),
                                      )
                                    : controller.path.value != null
                                        ? CircleAvatar(
                                            radius: 60,
                                            foregroundImage: FileImage(File(
                                                "${controller.path.value}")),
                                            child: const Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 40),
                                          )
                                        : CircleAvatar(
                                            radius: 60,
                                            foregroundImage:
                                                NetworkImage(image!),
                                            child: const Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 40),
                                          ),
                              ),
                            ),
                          ),
                          Text(pName, style: txt18),
                          buildSizedBox(),
                          CustomTextField(
                              label: 'Name', controller: txtName, color: green),
                          sizedBox(),
                          Text(pMobile, style: txt18),
                          buildSizedBox(),
                          CustomTextField(
                              label: 'Mobile',
                              controller: txtMobile,
                              color: green),
                          sizedBox(),
                          Text(pEmail, style: txt18),
                          buildSizedBox(),
                          CustomTextField(
                              label: 'Email',
                              controller: txtEmail,
                              color: green),
                          sizedBox(),
                          Text(pBio, style: txt18),
                          buildSizedBox(),
                          CustomTextField(
                              label: 'Bio', controller: txtBio, color: green),
                          sizedBox(),
                          Text(pAddress, style: txt18),
                          buildSizedBox(),
                          CustomTextField(
                              label: 'Address',
                              controller: txtAddress,
                              color: green),
                          buildSizedBox(),
                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(green)),
                              onPressed: () async {
                                String? path;
                                if (controller.path.value != null) {
                                  path = await FireStorage.fireStorage
                                      .uploadProfile(controller.path.value!);
                                }
                                ProfileModel p1 = ProfileModel(
                                  uid: FireHelper.fireHelper.user!.uid,
                                  name: txtName.text,
                                  mobile: txtMobile.text,
                                  bio: txtBio.text,
                                  email: txtEmail.text,
                                  address: txtAddress.text,
                                  image: controller.path.value != null
                                      ? path
                                      : image,
                                );
                                FireDbHelper.fireDbHelper.addProfile(p1);
                                controller.path.value = null;
                                Get.offAllNamed('dash');
                              },
                              child: Text('Save', style: txt16),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox sizedBox() => const SizedBox(height: 10);

  SizedBox buildSizedBox() => const SizedBox(height: 15);
}
