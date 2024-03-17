import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_miner/screen/chat/model/chat_model.dart';
import 'package:firebase_miner/screen/profile/model/profile_model.dart';
import 'package:firebase_miner/screen/setting/controller/setting_controller.dart';
import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/helper/fire_helper.dart';
import 'package:firebase_miner/utils/helper/firedb_helper.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController txtMsg = TextEditingController();
  ProfileModel profileModel = Get.arguments;
  SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: Text(profileModel.name!, style: txtWhite),
            backgroundColor: green,
            actions: [
              Icon(Icons.video_call,
                  color: controller.isLight.value == false ? black : white,
                  size: 27),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: () async {
                    Uri uri = Uri.parse("tel: +91 ${profileModel.mobile}");
                    await launchUrl(uri);
                  },
                  icon: Icon(Icons.call,
                      color:
                          controller.isLight.value == false ? black : white)),
              Icon(Icons.more_vert,
                  color: controller.isLight.value == false ? black : white,
                  size: 25),
              const SizedBox(width: 10),
            ],
            leading: profileModel.image == null
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 30,
                      child: Text(
                          profileModel.name!.toUpperCase().substring(0, 1)),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(profileModel.image!),
                  ),
          ),
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
            profileModel.docId == null
                ? Container()
                : StreamBuilder(
                    stream:
                        FireDbHelper.fireDbHelper.readChat(profileModel.docId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        List<ChatModel> messageList = [];
                        QuerySnapshot? qs = snapshot.data;
                        if (qs != null) {
                          List<QueryDocumentSnapshot> qsDocList = qs.docs;
                          for (var x in qsDocList) {
                            Map data = x.data() as Map;
                            ChatModel c1 = ChatModel(
                                name: data['name'],
                                msg: data['msg'],
                                time: data['time'],
                                date: data['date'],
                                id: data['id'],
                                docID: x.id);
                            messageList.add(c1);
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 80),
                          child: ListView.builder(
                            reverse: true,
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: messageList[index].id ==
                                        FireHelper.fireHelper.user!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: GestureDetector(
                                  onLongPress: () {
                                    if (messageList[index].id ==
                                        FireHelper.fireHelper.user!.uid) {
                                      Get.defaultDialog(
                                        content:
                                            Text('${messageList[index].msg}'),
                                        title: 'Delete',
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                FireDbHelper.fireDbHelper
                                                    .deleteMessage(
                                                        profileModel.docId!,
                                                        messageList[index]
                                                            .docID!);
                                                Get.back();
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: controller.isLight.value == false
                                          ? Colors.grey.shade900
                                          : cyan,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: Radius.circular(
                                            messageList[index].id ==
                                                    FireHelper
                                                        .fireHelper.user!.uid
                                                ? 10
                                                : 0),
                                        bottomRight: Radius.circular(
                                            messageList[index].id ==
                                                    FireHelper
                                                        .fireHelper.user!.uid
                                                ? 0
                                                : 10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: messageList[index]
                                                  .id ==
                                              FireHelper.fireHelper.user!.uid
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text('${messageList[index].msg}',
                                            style: txt18),
                                        Text('${messageList[index].name}',
                                            style: GoogleFonts.comicNeue()),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 65,
                margin: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txtMsg,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          prefixIcon: Icon(Icons.mood, size: 25, color: black),
                          suffixIcon: InkWell(
                              onTap: () async {
                                ImagePicker picker = ImagePicker();
                                await picker.pickImage(
                                    source: ImageSource.camera);
                              },
                              child: Icon(Icons.camera_alt,
                                  size: 25, color: black)),
                          filled: true,
                          fillColor: white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                        onPressed: () {
                          ChatModel model = ChatModel(
                              id: FireHelper.fireHelper.user!.uid,
                              name:
                                  FireDbHelper.fireDbHelper.myProfileData.name,
                              time:
                                  '${DateTime.now().hour}:${DateTime.now().minute}',
                              date:
                                  '${DateTime.now().day}-${DateTime.now().month}',
                              msg: txtMsg.text);
                          FireDbHelper.fireDbHelper.sendMessage(
                              model,
                              FireDbHelper.fireDbHelper.myProfileData,
                              profileModel);
                          txtMsg.clear();
                        },
                        icon: const Icon(Icons.send)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
