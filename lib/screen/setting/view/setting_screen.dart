import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/constant.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
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
            title: Text('Settings', style: TextStyle(color: white)),
            backgroundColor: green),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: grey)),
            padding: const EdgeInsets.all(10),
            child: StreamBuilder(
              stream: FireDbHelper.fireDbHelper.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  DocumentSnapshot ds = snapshot.data!;
                  Map m1 = ds.data() as Map;
                  return Row(
                    children: [
                      m1['image'] == null
                          ? CircleAvatar(
                              radius: 50,
                              child: Text('${m1['name']}'
                                  .toUpperCase()
                                  .substring(0, 1)),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage('${m1['image']}'),
                            ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${m1['name']}', style: txtHeading20),
                          Text('${m1['mobile']}', style: txtMedium14),
                        ],
                      )
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          InkWell(
              onTap: () {
                Get.toNamed('profile');
              },
              child: buildListTile(
                  CupertinoIcons.profile_circled, 'Edit Profile')),
          buildListTile(Icons.person_off_outlined, 'Blocked users'),
          buildListTile(Icons.delete_outline, 'Delete account'),
          buildListTile(Icons.privacy_tip_outlined, 'Privacy policy'),
          buildListTile(
              Icons.playlist_add_check_circle_outlined, 'Terms & condition'),
          InkWell(
              onTap: () async {
                await FireHelper.fireHelper.logOut();
                Get.snackbar(logout, 'Success');
                Get.offAllNamed('signIn');
              },
              child: buildListTile(Icons.logout, 'Logout')),
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
