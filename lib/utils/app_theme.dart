import 'package:firebase_miner/utils/color_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white12,
    titleTextStyle: GoogleFonts.itim(color: black),
  ),
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: black),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: black,
    titleTextStyle: GoogleFonts.itim(color: white),
  ),
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: white),
);
