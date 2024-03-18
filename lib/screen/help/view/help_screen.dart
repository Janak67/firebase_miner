import 'package:firebase_miner/utils/color_list.dart';
import 'package:firebase_miner/utils/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: green,
            actions: const [Icon(Icons.more_vert)],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SearchBar(
                  elevation: const MaterialStatePropertyAll(1),
                  leading: const Icon(Icons.search),
                  hintText: 'Search Help Center',
                  hintStyle: MaterialStatePropertyAll(TextStyle(color: grey)),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Help topics', style: txt16),
                ),
              ),
              buildListTile(Icons.flag, 'Get Started'),
              buildListTile(Icons.chat, 'Chats'),
              buildListTile(Icons.business, 'Connect with Businesses'),
              buildListTile(Icons.call, 'Voice and Video Calls'),
              buildListTile(Icons.groups_sharp, 'Communities'),
              buildListTile(Icons.wifi_channel, 'Channels'),
              buildListTile(Icons.lock, 'Privacy, Safety, and Security'),
              buildListTile(Icons.account_circle, 'Accounts and Account Bans'),
              buildListTile(Icons.payment, 'Payments'),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: CupertinoColors.activeGreen),
      title: Text(text),
    );
  }
}
