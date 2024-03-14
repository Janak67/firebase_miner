import 'package:firebase_miner/utils/color_list.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  Color? color;
  String? label;
  IconData? icon;

  CustomTextField(
      {super.key, this.controller, this.label, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        labelStyle: TextStyle(color: color ?? grey),
        suffixIcon: icon != null ? Icon(icon) : null,
        labelText: label ?? "",
      ),
    );
  }
}
