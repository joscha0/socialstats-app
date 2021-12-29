import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> theme = ThemeData.light()
      .copyWith(
        textTheme: GoogleFonts.bangersTextTheme(),
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
      )
      .obs;
}
