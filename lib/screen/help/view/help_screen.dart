import 'package:firebase_miner/utils/color_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            buildListTile(),
            buildListTile(),
            buildListTile(),
            buildListTile(),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile() {
    return const ListTile(
            leading: Icon(Icons.flag, color: CupertinoColors.activeGreen),
            title: Text('Get Started'),
          );
  }
}
