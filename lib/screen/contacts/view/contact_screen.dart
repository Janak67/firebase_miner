import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            title: Text('Contacts', style: txtWhite), backgroundColor: green),
      ),
      body: StreamBuilder(
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
                          radius: 30,
                          backgroundImage:
                              NetworkImage('${contactData[index].image}'),
                        )
                      : CircleAvatar(
                          radius: 30,
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
                    style: txt18,
                  ),
                  subtitle: Text(
                    '${contactData[index].mobile}',
                    style: txt18,
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
