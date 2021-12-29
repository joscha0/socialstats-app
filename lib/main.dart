import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/home/home_page.dart';
import 'services/theme_controller.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends GetView<ThemeController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
        init: ThemeController(),
        builder: (c) {
          return GetMaterialApp(
            themeMode: ThemeMode.light,
            theme: c.theme.value,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        });
  }
}
