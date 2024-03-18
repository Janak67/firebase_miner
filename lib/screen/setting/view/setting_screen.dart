import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/helper/share_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.name);
  }

  SettingController controller = Get.put(SettingController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getProfile();
  }

  Future<void> getProfile() async {
    await FireDbHelper.fireDbHelper.myProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            title: Text('Settings', style: txtWhite), backgroundColor: green),
      ),
      body: Stack(
        children: [
          Obx(
            () => controller.isLight.value == false
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
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grey)),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    FireDbHelper.fireDbHelper.myProfileData.image == null
                        ? CircleAvatar(
                            radius: 50,
                            child: Text(
                                '${FireDbHelper.fireDbHelper.myProfileData.name}'
                                    .toUpperCase()
                                    .substring(0, 1)),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                '${FireDbHelper.fireDbHelper.myProfileData.image}'),
                          ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${FireDbHelper.fireDbHelper.myProfileData.name}',
                            style: txtHeading20),
                        Text(
                            '${FireDbHelper.fireDbHelper.myProfileData.mobile}',
                            style: txtMedium14),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.toNamed('profile');
                  },
                  child: buildListTile(
                      CupertinoIcons.profile_circled, 'Edit Profile')),
              ListTile(
                leading: Obx(
                  () => controller.isLight.value == false
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.light_mode_outlined),
                ),
                title: Text('Theme', style: txt20),
                trailing: Obx(
                  () => Switch(
                    value: controller.isLight.value,
                    onChanged: (value) {
                      ShareHelper shr = ShareHelper();
                      shr.setTheme(value);
                      controller.changeTheme();
                      Get.back();
                    },
                  ),
                ),
              ),
              buildListTile(Icons.person_off_outlined, 'Blocked users'),
              InkWell(
                  onTap: () async {
                    await FireDbHelper.fireDbHelper
                        .deleteUserDetail(FireHelper.fireHelper.user!.uid);
                    await FireHelper.fireHelper.deleteAccount();
                    Get.snackbar('Account has been Deleted', 'Success');
                    Get.offAllNamed('signIn');
                  },
                  child: buildListTile(Icons.delete_outline, 'Delete account')),
              buildListTile(Icons.privacy_tip_outlined, 'Privacy policy'),
              buildListTile(Icons.playlist_add_check_circle_outlined,
                  'Terms & condition'),
              InkWell(
                  onTap: () async {
                    await FireHelper.fireHelper.logOut();
                    Get.snackbar(logout, 'Success');
                    Get.offAllNamed('signIn');
                  },
                  child: buildListTile(Icons.logout, 'Logout')),
              InkWell(
                  onTap: () {
                    Get.toNamed('help');
                  },
                  child: buildListTile(Icons.help_outline, 'Help')),
              buildListTile(Icons.group_outlined, 'Invite a friend')
            ],
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text, style: txt20),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
