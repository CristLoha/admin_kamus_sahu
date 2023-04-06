import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/edit.controller.dart';

class EditScreen extends GetView<EditController> {
  final dynamic data = Get.arguments;
  EditScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
