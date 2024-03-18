import 'package:firebase_miner/screen/profile/controller/profile_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void showBottom(BuildContext context) {
  ProfileController controller = Get.put(ProfileController());
  String? image;
  Size size = MediaQuery.of(context).size;
  double h = size.height;
  double w = size.width;
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: h * 0.15,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(w * 0.08),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Choose Photo',
              style: TextStyle(
                  fontSize: w * 0.05,
                  color: black,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? img =
                            await picker.pickImage(source: ImageSource.camera);
                        controller.path.value = img?.path;
                        Get.back();
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: w * 0.09, color: black),
                    ),
                    Text(
                      'Camera',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? img1 =
                            await picker.pickImage(source: ImageSource.gallery);
                        controller.path.value = img1?.path;
                        Get.back();
                      },
                      icon: Icon(Icons.photo_camera_back_outlined,
                          size: w * 0.09, color: black),
                    ),
                    Text(
                      'Gallery',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          // String? path;
                          // ProfileModel p1 = ProfileModel(
                          //   uid: FireHelper.fireHelper.user!.uid,
                          //   image: controller.path.value != null ? path : image,
                          // );
                          // FireDbHelper.fireDbHelper.addProfile(p1);
                          // controller.path.value = null;
                          // Get.offAllNamed('dash');
                        },
                        icon: Icon(Icons.delete_outline,
                            size: w * 0.09, color: black)),
                    Text(
                      'Profile photo remove',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
