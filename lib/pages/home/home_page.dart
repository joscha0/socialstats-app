import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igstats/pages/profile/profile_page.dart';
import 'package:igstats/pages/search/search_page.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
        init: HomeController(),
        builder: (c) {
          return Scaffold(
            body: IndexedStack(
              index: c.tabIndex.value,
              children: [
                SearchPage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => c.tabIndex.value = value,
              currentIndex: c.tabIndex.value,
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
              unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
              selectedFontSize: 24,
              unselectedFontSize: 22,
              items: [
                _bottomNavigationBarItem('search'),
                _bottomNavigationBarItem('profile')
              ],
            ),
          );
        });
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String label) {
    return BottomNavigationBarItem(
        icon: const Icon(Icons.ac_unit), label: label);
  }
}
