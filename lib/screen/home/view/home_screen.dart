import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  SettingController controller = Get.put(SettingController());

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
            title: Text('Chat', style: txtWhite), backgroundColor: green),
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
            stream: FireDbHelper.fireDbHelper.chatContact(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                List<ProfileModel> chatContact = [];
                QuerySnapshot? qs = snapshot.data;
                if (qs != null) {
                  List<QueryDocumentSnapshot> qsList = qs.docs;
                  for (var x in qsList) {
                    List mainList = [];
                    Map data = x.data() as Map;
                    for (var e in data.entries) {
                      mainList.add(e.value);
                    }
                    if (mainList[0].contains(FireHelper.fireHelper.user!.uid)) {
                      ProfileModel p1 = ProfileModel(
                          name: mainList[1][0],
                          uid: mainList[1][1],
                          image: mainList[1][2],
                          mobile: mainList[1][3],
                          docId: x.id);
                      chatContact.add(p1);
                    } else if (mainList[1]
                        .contains(FireHelper.fireHelper.user!.uid)) {
                      ProfileModel p1 = ProfileModel(
                          name: mainList[0][0],
                          uid: mainList[0][1],
                          image: mainList[0][2],
                          mobile: mainList[0][3],
                          docId: x.id);
                      chatContact.add(p1);
                    }
                  }
                }
                return ListView.builder(
                  itemCount: chatContact.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('chat', arguments: chatContact[index]);
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        color: index % 2 == 0
                            ? Colors.grey.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.2),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            chatContact[index].image == null
                                ? CircleAvatar(
                                    radius: 28,
                                    child: Text(chatContact[index]
                                        .name!
                                        .toUpperCase()
                                        .substring(0, 1)),
                                  )
                                : CircleAvatar(
                                    radius: 28,
                                    backgroundImage:
                                        NetworkImage(chatContact[index].image!),
                                  ),
                            const SizedBox(width: 18),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${chatContact[index].name}',
                                    style: txtBold20),
                                Text('${chatContact[index].mobile}',
                                    style: google),
                              ],
                            ),
                          ],
                        ),
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
