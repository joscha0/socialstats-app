import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ProfilePage')),
        body: SafeArea(child: Text('ProfileController')));
  }
}
