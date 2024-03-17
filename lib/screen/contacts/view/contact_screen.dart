import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            title: Text('Contacts', style: txtWhite), backgroundColor: green),
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
          StreamBuilder(
            stream: FireDbHelper.fireDbHelper.getAllContact(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                List<ProfileModel> contactData = [];
                QuerySnapshot? qs = snapshot.data;
                if (qs != null) {
                  List<QueryDocumentSnapshot> qsList = qs.docs;
                  for (var x in qsList) {
                    Map m1 = x.data() as Map;
                    ProfileModel p1 = ProfileModel(
                      uid: m1['uid'],
                      name: m1['name'],
                      image: m1['image'],
                      bio: m1['bio'],
                      email: m1['email'],
                      mobile: m1['mobile'],
                      address: m1['address'],
                    );
                    contactData.add(p1);
                  }
                }
                return ListView.builder(
                  itemCount: contactData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed('chat', arguments: contactData[index]);
                      },
                      leading: contactData[index].image != null
                          ? CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage('${contactData[index].image}'),
                            )
                          : CircleAvatar(
                              radius: 28,
                              child: Text(
                                contactData[index]
                                    .name!
                                    .toUpperCase()
                                    .substring(0, 1),
                                style: TextStyle(color: black),
                              ),
                            ),
                      title: Text(
                        '${contactData[index].name}',
                        style: txtBold20,
                      ),
                      subtitle: Text(
                        '${contactData[index].mobile}',
                        style: google,
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
