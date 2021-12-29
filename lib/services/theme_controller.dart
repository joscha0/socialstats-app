import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> theme =
      ThemeData.light().copyWith(textTheme: GoogleFonts.bangersTextTheme()).obs;
}
