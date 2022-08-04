import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_app_controller.dart';

class AboutAppView extends GetView<AboutAppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AboutAppView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AboutAppView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
